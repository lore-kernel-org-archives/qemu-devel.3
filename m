Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16494C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeJl-0003fr-Im; Tue, 28 Jul 2026 05:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJj-0003Rh-Fb
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJh-0007WF-Nx
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:43 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82F2h2480199
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Il9BSu/Ho7J8AcXZWEYJWnCZeHZP+9NrkyIWkDEsvKM=; b=cqmk+B0uKDgbXTg1
 Xa0QdiiUMUqEYwZqHW8z+0OGrmoaLx/hMyCeOVYArw+ZAzEb5Vgs5hgBzrZETPzJ
 Zu+nfm92bxrtj+Js5DuVfIzphzv/FTggZ8n7nheYapCKvmV0dEVjr/i5Jx+EFqsu
 vgkqV04aG6ac4ueatClDMPy2G/xQys8bpOfN93yNsxHSY09mgXKLNG6sA+wVODhl
 edD0dTV+/YFxKvhA39cCsnS0m5UISIscJ7jcxbeXQKqDvFgsI1dgnR5bzHa74gI5
 EpUD6RpWJQLM8NOgNfTPG6bPUYiR+kEFzfk09gjv8u2zDSnV4dydVY+M7HLhvJoi
 DFICww==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy119fe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:41:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c12e43b98so45014861cf.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785231699; x=1785836499; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Il9BSu/Ho7J8AcXZWEYJWnCZeHZP+9NrkyIWkDEsvKM=;
 b=W9qXIjkDFp0bo7z9b3EcpwTDb1kf9MTAJx16rQP/B6faYs+cVPxJ/MkOgzZBK8ycS7
 KvAlsbABwGjk3hNGeh7t7ciHklUlqKO+OHvqKJDj1bnME5VvGPDH1GtSJYsoJdjz7cy7
 pSKCOchzyYIiaOvTfJxxjlS5HRzC6b7hYWNx/3lNAOQiUHro8WAzqCcbaHrYYevunVde
 47wA3fquhag1aSt02Xj4yI8xOH8TAq/bavQ54GhLSqXH63oPPklR69QH85C4cD2WHNFq
 J+U4K1OmHMFQyj5scWlxZU6wgG1XJpXMYqAyc/0WySqCji+EZ5LSCgXM6MFVOcCBOkh4
 iP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785231699; x=1785836499;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Il9BSu/Ho7J8AcXZWEYJWnCZeHZP+9NrkyIWkDEsvKM=;
 b=pwkMsnPQFdhncPGXN0indlx25KerU8XTWEpbrHlJg8i3NuGUrwHHzUWAAi6WdZNjkx
 09hJAb09m3445ya1yDrOiRbEzDZ3vw/9S5UjpEBizn3jJkA52MkHwk42HXC3IM//HsMW
 HrIdcRCrBNuzXGq40up74T35Zjwh1HqccJ5UMMGmP49CH84ZWc2dHUjUe1K4MfRsrbJa
 RcAES0rsDt8Ci3yxEkimGxQF5SIHPNPP/QQh9AJt5l/Q2Jg5MRb5DnUS9r/8a5OfZreq
 N8CGcgSDmHVjK9KrnmcIFKxkzjD6JgJuN9hZl+Wyw3I5A3T8MZJW1DZfxKepVDooBJAu
 8kog==
X-Gm-Message-State: AOJu0Yz0YxhuMDKvZuvIG7h8Fw9SRa9ZgTVbAcnLDjHjUNe5yPN8NsQc
 wONKtWOivasF5SdtpIi1Et87UzgBEGKaGML3n6d1OYObivcsqT6FpFS8iXyZYhlJ/fddHHIzsll
 VrHJqnjiFI9QKA6e4Y1rqGNU0QgWs8rTZdunaA105I56L1GqebHevrFVSOly62x6hFg==
X-Gm-Gg: AR+sD13nLZqL9PPteQ0w57MuOkp2JB5MZviNExEhuAxiV2mVUxv+0VmV1RWaV8IfPjy
 VBgsH6LLhGT7aBQ1ZeBo2+gpDYLucs2NSbDx2JZDv1Mt0OB2PBAdgOW0l++ERh7+MzE54p/ZxW3
 jFLwa7hvLDitjKALqp7TuVRR8yI8urlmmLFRi+u0/GorkGVaT6BLu4HI48itWTJo1gtmJ00qyiq
 Xv0eKfO2Xilkjv7hipkAGb8Hj1VAZpxGxaVrJQLJ39OSKvGSofbqq5DkzRTWHw+80MNQ+P6T7a3
 t5WLJSoBuly6WclYhIl7AXNhrQnwNTGkRocKVYGpaC4nqb/A5P7B1W+HKzle/8tcoQ7xtlf2Mjk
 7uYQNJhkgXgGN76API+QE3omBOQD2od0H5GFt5FqGrIFuLIBpsoP9wq3B+A==
X-Received: by 2002:a05:622a:1804:b0:51c:21d1:3852 with SMTP id
 d75a77b69052e-529d6fafaa1mr12404931cf.5.1785231699143; 
 Tue, 28 Jul 2026 02:41:39 -0700 (PDT)
X-Received: by 2002:a05:622a:1804:b0:51c:21d1:3852 with SMTP id
 d75a77b69052e-529d6fafaa1mr12404671cf.5.1785231698615; 
 Tue, 28 Jul 2026 02:41:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45c297dsm58857805e9.7.2026.07.28.02.41.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jul 2026 02:41:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] tests/functional/ppc: skip remote interrupts test if -net
 user not built
Date: Tue, 28 Jul 2026 11:40:55 +0200
Message-ID: <20260728094055.12684-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728094055.12684-1-philmd@oss.qualcomm.com>
References: <20260728094055.12684-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bZwOSpamQhjre7nM-ddQ9_Cenw1LfnK5
X-Proofpoint-ORIG-GUID: bZwOSpamQhjre7nM-ddQ9_Cenw1LfnK5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4NCBTYWx0ZWRfX3zab5Hr90yCE
 d717g7qu+UWAj/hcaLx/+p+0Nqc6DmcO6Ztswd3YvQhbA62kupsiL0EvuWfEBkxzZK2hKBEDsE1
 rYKu9P3DEfCo7sHY4XeuTAY0QhxFWAlSPrvwbtd0p/L0C4OWgOpPD2PZ/RT19wh4mfDJTvCiiEo
 0fwD3U3BPVWhu1frkpw12p7m9R4ukLwsV9UEFu+Cs6vKiKv4P3IyG9GbU1lMUtJLvVOUqMxeZhU
 iTxjpfwFU05ibZQLrESk2p8wGMubBcKfGC2yOn6XqqJ65K9HPW7R51W7y6zKOzVMpPljrRPY44d
 3TEl6+ha9qPVt+NE09N8SJd3EeT0lTipwmZYu0e+n0pnCpdeBoYqM4qwt8FN6J2YYEd1/Igm+PQ
 b+MJMEZumEM7OgfeJkQhkSI9NVMDmEDWcMJFIPPBTQfNwQ4qQf5TT+1adV+z8kdWxot/u9ghro4
 XGt6+5pfZydr+7lW1cA==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a687954 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=_mrNEnGEA0-oycTHUFkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4NCBTYWx0ZWRfXz3XPCMeaGUKf
 ZRoEGJjvUOzZyhp0bZQdGroz0EFAZmfbLTDXGXG61DdEXNcTCwSazcnXAHr9/ZQMY3/Yi9857Ba
 h0zr69PJ4jHx+voxqrz6f2WvEMFym84=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

While running remote interrupts test, without libslirp-devel installed,
facing the following panic logs.

  File
    ...
    raise VMLaunchFailure(
    ...<3 lines>...
    ) from exc
    ...
        Output: qemu-system-ppc64: -netdev user,id=net0: network backend
'user' is not compiled into this binary

Adding netdev user requirement for this test.

Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Fixes: 63f5ba80921 ("tests/functional: Add remote interrupts test for PowerNV")
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Message-ID: <20260728074612.42397-1-shivangu@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/functional/ppc64/test_powernv.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index bac2017e18d..f3e05e4d381 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -90,6 +90,7 @@ def test_linux_smt_boot(self):
 
     def test_linux_remote_interrupts(self):
         self.require_accelerator("tcg")
+        self.require_netdev('user')
         self.set_machine('powernv')
 
         # Have below setup in this test:
-- 
2.53.0


