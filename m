Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA9BD19511
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQf5-0003pP-PM; Mon, 26 Jan 2026 12:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vkQep-0003XA-01
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:45:47 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vkQem-0000fX-Jh
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:45:46 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60QErWaL171886
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 17:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=eHQH2qlb584cCx0W0bYp51ye5L+3R6gAlqp
 qn0dCSbE=; b=ebmBRqNa87cwD8nHFk/MtxX0MlWkPxAMYylUiH8W+uGl9WsNuuK
 h+w/z99FBqWeq49CSlFQnipwHMuMFCGKlyF/0RTMEHHAA5XDoYKUUCNDWL31I9pU
 w30gbMC2PbOv9xevvKHVvYdX+D6/KuVprfge+KiWFCoLTegKsRBi4I562QuDpJL6
 8cGxbDtJSH2hai7tJ5FuQ/Qp6b9MDc7omUdfaxMxyrHFdUJTWybrvKjd4h8lycw/
 twYidt4WM3kGs2kzErdrqYVpTd8KDvN0xUCdgT6TolESzmyJ7QmxC/U2tCyKAeWG
 9kDQjD0ZQ0K3Y4jOXlbvlaqcvujNeZ1xhdg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxadprh3a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 17:45:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c277fe676eso1366989385a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769449540; x=1770054340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eHQH2qlb584cCx0W0bYp51ye5L+3R6gAlqpqn0dCSbE=;
 b=c4Iwl8EnwLaCIz473qca3+I8NzS/O0e6hUgngdFSpKQuUAYXkVhqPfJ4jT//vJ/w4a
 Nk/8ltYQMl2cttgc53ktKF3RO3aEBTIb2HsLaNZeAKKIV6Ga8ynaUImjFa9em93YArz8
 bgr+dOdPkjQKpcl5ff9Kz2w6T6NQZF6JkUHTHXXnG0GST8jYvR9c1ViliO4bFCJpgQcp
 4ZAPXUVnbUrJHfYxvoEmPFZhgXzCy/1Nhirg/Lf51BqeDNKECAoUVBpN5W4/9kdMVHOk
 2dfx32Yk6mtL6Kl2+ZxTD4pmvdPUINjy56s6MaUfsK7nEqn4ErCBq0XGZAWW8OtxZn6c
 w1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449540; x=1770054340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHQH2qlb584cCx0W0bYp51ye5L+3R6gAlqpqn0dCSbE=;
 b=Ci9AIbvw1Yhp3jaPKOtDU3QRKfauA9EuNIHvA/+wDxvtGSxP2rEhmBr4XfhMvb560z
 gWNYrOBglh4i23CGIDfba+URt5uT3zHRG6MML9H2/HXoy1GqrAJoFQKl68h45ia/VCky
 w7lU8Kil8ippb64GZ0FstaTgocblB8AGBITQC/RNn/mWyqlNDl2+NBbeiy2Ha00RRSx/
 QQkpiCswXNh/beejOch2MTzxwk0sAZ3YFRbk1B6I0mQWNrO7OFU5Sid9mRRKU767mkOF
 Qjv2TmnBqOAFyPPnrqemNMcbyL/VD8LCtd23Gu/I6GR05FsD+Gi2Kd8ZsktBhFl9i+pK
 2AFQ==
X-Gm-Message-State: AOJu0YxKJ2QNHqd4WJE2p7SJLDJI+QnrrvWcttknepdICAasLidURmRg
 9SdqWJ5duptns0pRVRRmeFFt6wAkPj2znW+h1zOLbdk/UqW1aUrYgLWb+25E4oGkVyvP3uFzKHD
 jn0HW/wMfK6oxdC5oRdJ7NaT2YrnU+W/fgrLdxVga6JAsnzEGwkUPG/t4l4O80ZgryA==
X-Gm-Gg: AZuq6aKPqDaNVkptvxj6nE+AdqAOUhtQOysxWHTB36kJq4KD2nSFo4ZPG1lHaXMD+rK
 3355TDXBOQ+YfNQ5mrpZqV8JwS8ofyEAPdm+w8+nnP0ddeWwIiC7lQiRf4xs7iRs91rYAXDv9fh
 t9w3494LZjjTOD/oxnH1GMi9LBS/X2Nq/4GSebRE8V5CchhqaF0tIFgIBv4rCTbOtKfZYw+GJzO
 G24DNzQNbwdqUSiod2TH0ozswtlY14+jbMXSFwgdjdcllMirUGmn/mtU87SyTktiIkX5YjtIQ1X
 D0UMjJ0bGedPcjO3vUGJzT9U0Do2qReGEOwKAfSsuqMyil4DoBQhmuHDxcjgnHYuSmdd/YyYfOB
 MPLLZ9jX5xgyV+m2KcMYBkdFJEPQWk9f4lAh1OYoc1h78AN4=
X-Received: by 2002:a05:620a:4109:b0:8b2:64b1:692c with SMTP id
 af79cd13be357-8c6f95c6e74mr631951785a.29.1769449540369; 
 Mon, 26 Jan 2026 09:45:40 -0800 (PST)
X-Received: by 2002:a05:620a:4109:b0:8b2:64b1:692c with SMTP id
 af79cd13be357-8c6f95c6e74mr631946885a.29.1769449539892; 
 Mon, 26 Jan 2026 09:45:39 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.122.35])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e37c61ffsm1075788885a.7.2026.01.26.09.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:45:39 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 djordje.todorovic@htecgroup.com, thuth@redhat.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] riscv64/test_boston.py: fix intermitent test timeout
Date: Mon, 26 Jan 2026 14:45:34 -0300
Message-ID: <20260126174534.9860-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6BoncDmjOJYp3LaTFK7UKOATHuJnCipE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE1MSBTYWx0ZWRfX0G1B1eSwt7jW
 bJh2EIyi1utpAVYqvooP66KXobMKihMIVOfW5GEuLxgQLskDp+40FBdRCtz5Jpxed9IcaDdpago
 zd8HnT5pbS9ChrRxKTUhuyWJey+lAMsAUyKvWfSOLO9TYIxk4a/Nrwx+8+dPVMZ8PDU6o93iquG
 Em+hwJ5rYdqy/EH4LlLTgGI6jDR4wggHeqvTlg/Na1KIoDbAUMlRCd2DYRO5dn0eqjFOS8EozoN
 obDXPB5t5Wku8W8JTpJAruo0wktm/VWG7JkFJk2T9oF5IMhJl42C9oQkz4WiAwmdwdOWYr8PQyR
 yXqusa7Mtk9qm7WV3iZO3QFORgs1C2K7GOOCGAkxe8HuB+Dr1qRbACSMp+bH4LXpIicUSixOjGf
 R9menMHiGctIVEdMOVZMr/uDragWbo/JkghLV3z0ldA0bgp9Dnt5hq4gA2XrfP+iqAA/KkrjNuR
 h1j6jQneOQUXDgWyKwQ==
X-Authority-Analysis: v=2.4 cv=GvdPO01C c=1 sm=1 tr=0 ts=6977a845 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=DAX9FfZ9XxEyxcLR5JSMEA==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=QEW72FK1AuS7OZBB5Y8A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 6BoncDmjOJYp3LaTFK7UKOATHuJnCipE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260151
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The recently added Boston MIPS board selftest times out consistently in a
machine running 'make check-functional' with -j 16:

18/18 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64-boston
      TIMEOUT        120.09s   killed by signal 15 SIGTERM

The reason is quite boring: it is testing too much stuff.

Note that functional tests aren't supposed to be used as stress tests,
e.g. it doesn't have to test every single corner case that might hit the
board. It is supposed to catch most common user ooopsies. A timeout, in
this context, is most likely to be considered something abnormal slowing
down the emulation, not a lack of CPU horsepower to run all the tests
before timeout.

Some of the tests claim to test odd CPU SMP numbers to either "ensures
proper core distribution across clusters" or "validating proper handling
of larger asymmetric SMP configurations". But there's no SMP/NUMA check
made anywhere after boot, so in the end we're just testing whether the
board is able to boot with 7/35 CPUs. As far as these tests are concerned
we could have a completely broken, but bootable, SMP topology with 7/35
CPUS, and we're oblivious about it.

Remove the 7 and 35 SMP tests, keeping the minimal CPUs (2) and maximum
(64) tests. With these changes we're now able to run the test with a
good TIMEOUT margin:

17/18 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64-boston
      OK              61.28s   3 subtests passed

Fixes: e71111e26b ("test/functional: Add test for boston-aia board")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 tests/functional/riscv64/test_boston.py | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/tests/functional/riscv64/test_boston.py b/tests/functional/riscv64/test_boston.py
index 385de6a61d..13c44ca3e3 100755
--- a/tests/functional/riscv64/test_boston.py
+++ b/tests/functional/riscv64/test_boston.py
@@ -63,25 +63,6 @@ def test_boston_boot_linux_min_cpus(self):
         """
         self._boot_linux_test(smp_count=2)
 
-    def test_boston_boot_linux_7_cpus(self):
-        """
-        Test Linux kernel boot with 7 CPUs
-
-        7 CPUs is a special configuration that tests odd CPU count
-        handling and ensures proper core distribution across clusters.
-        """
-        self._boot_linux_test(smp_count=7)
-
-    def test_boston_boot_linux_35_cpus(self):
-        """
-        Test Linux kernel boot with 35 CPUs
-
-        35 CPUs is a special configuration that tests a non-power-of-2
-        CPU count above 32, validating proper handling of larger
-        asymmetric SMP configurations.
-        """
-        self._boot_linux_test(smp_count=35)
-
     def test_boston_boot_linux_max_cpus(self):
         """
         Test Linux kernel boot with maximum supported CPU count (64)
-- 
2.43.0


