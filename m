Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BAAC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ23-0005wT-P3; Fri, 10 Jul 2026 17:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1j-0005WH-J4
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1i-0003Wj-1q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKDc1A1811761
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wwak1i+Z7YShzNB0prJqmDShxkxQBGZxGdlmBmYltbA=; b=ZKRIg3pBm/TfS0Jw
 h7sNwfeoowqri5Fi2nYS0Z2kfuNiDe/pgqfi+pxQJDpuLVZyrADHmb0R4rLqUFz+
 LwU/Fg9nZnXQGWHcmLvinKTnXnYTD8zDx06crqIi7zySUjAt0h8uy7xsSWNLXR6P
 nshOBggfZavvQzUD9hBaN1M3hiC6Zk8OYqub0PZzZmO4O/r/CHSsNrDXMIADeabs
 1+VJcfAL/JXGInMO+xivRrklQX9ZNQmaA9YEo+EQRT9LmO/uBwQfTrZcAA+D2TYs
 lJsk/mJGZGpzAcvelzFl+VqsCEnXy9aYkaNBklhBSi/Bzbokg1giAV4Zpa931GpY
 8A3C6w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5fahq5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9d5a5b63c5so1981160a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719882; x=1784324682; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wwak1i+Z7YShzNB0prJqmDShxkxQBGZxGdlmBmYltbA=;
 b=Vq/pj2qVvCXvY5i59ExTahDltvxOYOlfp0cqaq9jZA/43p68NTQ3kmkE/V4YUujHw+
 ycOYju6VuBTGHGlLUNHNejoE9QsEfccTb+wg2fRXlNsCYcBpN47o52VWYxbLmGkiqirj
 /Q/7DXVyVQQi6M6foBedvlL/C+EZiILx8JUZFFas4Im75aJyPmfbZ8+fM+pb2yz09zAQ
 79jZwj55EJ9BmnDOcC86GidpD/9IPzO6xpR8SYFXDaRCFDT/AP3wvGTlnQq4K1SD2mr+
 XGBc9/QPLuv4uItvbkIubs8CFp+zcDbbWBEQSWPIgv2yl894z4+KAqjIm/PLR4+KXYVh
 FhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719882; x=1784324682;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wwak1i+Z7YShzNB0prJqmDShxkxQBGZxGdlmBmYltbA=;
 b=UHVR7lY+mGha/unvT6Yl29rZvAqow6Jf/8fc4JkVDDVtyivv+79ugHMLpNo1E0DNWI
 9Xu32fYweZmxlFiqy3COerAFTLo29UwTpCcmoIsr87LcARFVS4aELEUwp+R8VBVG6U40
 LJjvnJW3BXGbjRc14W54ekfYjPjmL7yDkNICkPuD5ILKmbrqJ3tuNto+RTWmZGQYF4TM
 Tea3n5/GMW0NbBvMOY2uOHdJ62DhqQVq0N9UP6p3H8coiQ58R2/o/6A6kNGk9qeezoRS
 DntMlEz4u5+SEZKH64YKV2Pvdl9+rUlpu1u+Usv3dYTMh8aXayw85cq1zf8FQIVBXttM
 Uo/A==
X-Gm-Message-State: AOJu0Yw8FsOKT23EU2jjP8Id05WjJAJZyrXqU3iEXX6QgfZgwhEbOkk0
 beNSi7AadBFIt96Fm0oTrjlob4N3z/qiqGRaayk8XSlEJGTGArzNlY3DzuHCC2Jyx2Fr0N6V9yZ
 Q3LUyW6n/uM3VpASogKo7p3OqlwJUWcQ16t1wSLTwGjj21/Car5q7eVyDKLeXsDhJkw==
X-Gm-Gg: AfdE7cmda8PuBHKzMS2Sa4qXkEsC9Njgj8Ia7Fa5HfsJIohuGdL6mnT5yMd3Fzr6ViP
 SutvuRV8FDzer0P+L0SWQrQbkLFJgQJIfVeO87M3dtnixxxXJy3xrGwuYKkmNl667KRHeMPQSXv
 L6faFSCqWYxDZaJc6lQaA6PnRj9jyiLRnXT3hFTAoWEJYT+U+T+48K9YmrhQMVBHJupHFKn6waL
 wqVTtSNMJEI0D5g/8/LbZvgAncaF8/yfBbRU3YxlJW5wNW+bTng2Tl142rz32qnvJG9ROz8auE1
 MP5aXh+0sXRltPXbbj+i6HTedWcotprzPSKlZpf41K56dL7QpX1X0Ezf8KmFTdPUe0yiyQ7s/T1
 rALAkUbpOJfZvabYA6ciPx4N5AeojPn8GqHaHLWPkMwLny0ieAWzVcE8b6XZzDLkPw0kNHT6lrP
 Oem7Z36A==
X-Received: by 2002:a05:6a20:6f9c:b0:3c0:9c18:d5a3 with SMTP id
 adf61e73a8af0-3c110f7f721mr766368637.64.1783719882157; 
 Fri, 10 Jul 2026 14:44:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f9c:b0:3c0:9c18:d5a3 with SMTP id
 adf61e73a8af0-3c110f7f721mr766336637.64.1783719881669; 
 Fri, 10 Jul 2026 14:44:41 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 27/98] tests/docker/docker.py: remove "Image is up to date"
 info
Date: Fri, 10 Jul 2026 14:42:31 -0700
Message-ID: <20260710214343.2065491-28-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a5167cb cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Le2pUKrCS2B_8Q0jc7MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: l2TLoDdxUwD__ZG6ovRJIn61rMJe_OJn
X-Proofpoint-GUID: l2TLoDdxUwD__ZG6ovRJIn61rMJe_OJn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX9CBhm/r9nd3Z
 kfK9kI6nb6zjwcwU3KLap8+Usb0qsi+FFnJksmNI0kMth8lqx2DpUJfR0K61D0a0skhCpS3Gxnw
 HrDzP16JeEejDhmZXcKw2xGAmp3gCJw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXyGlP322xrPTH
 cS8HqsmdwqtIdumwIr5BY6nodatF+tXc1sO/8N0AoZKx0MPUA9Q8DtHWOtUrlYillCuzL5f52er
 oGOuTgR2xc5n2VwsOw0DxAEXhMb+ebDJhSMYtoQJgIprx9bCjgN19JgYB0C+uK7XRMHfKeTuzKv
 +jlSBBX/T7Zm3/SSh+B+5UYgfAAj9NLRM5C6wHc+UiUSBe9pVEg16a89JfgB6QAjlS3itWteW1e
 EDzd8l1zdRR/06r+TiehrU23JBcrijjzGHljSFsbaYSXrh90tGJ4yiha1F52h4nV4ixdpSXcFbr
 nibD6ye1hTNycTR/kuo59Z8/u391T4q34fHSHYlhaiU0E/aNiTc+Dl4WA/G1C79paSqiOfZ7aws
 LNDELIGXuBqjK1rnUSLUpbKKmyRdjifhgwhnxc3SpjrzPI+i/X01iNII2uqA8Mb2jwjyEXpW/VL
 AySHhovZa2yAs7HE9rA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

It's useful to print build output by default, but not useful to mention
it succeeded. Reduce verbosity of tcg tests build.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 6640cebfbec..128c0e6caad 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -448,8 +448,7 @@ def run(self, args, argv):
         dkr = Docker()
         if "--no-cache" not in argv and \
            dkr.image_matches_dockerfile(tag, dockerfile):
-            if not args.quiet:
-                print("Image is up to date.")
+            pass
         else:
             # Create a docker context directory for the build
             docker_dir = tempfile.mkdtemp(prefix="docker_build")
-- 
2.47.3


