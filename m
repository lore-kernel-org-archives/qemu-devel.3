Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD06CA6018
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 00:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEypJ-0004Gg-8Z; Thu, 08 Oct 2026 20:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEyot-0004DM-9c
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 20:50:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEyor-0003fc-8B
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 20:50:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990QIm8602214
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 00:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GRWH0yyKnT0v758YHnbtfFVpL80PTkKqdfh6mHGPiMI=; b=L5sY/eAD4KXAIiPj
 Qne2IvpWjf4agj+/KLfY2mRnMx5zwhOuAFanIcwZQLjcYecyH2fHQ0q3yoHyIwae
 7Uqjrsx9lw8SVafmzEaMI78FnSli6bjMM1sYaxYzj65J78/F5h9i80RvaHytt380
 BOy8oWeObCovwPujwUKsT04XXK13O1Xl7BH9UWxco4awCzlzOyO8VwYz0EzMSvO7
 mF0jbSkUqu0tTv9rK7vBEZVyzI/Mp3R+r+JGnvQQ4mC89CvCgJcf9I3IeSVEuWKJ
 hkR0jchjhyOX1vXatLDkE6xEOV504/Jl6TtF0Bz4PnNfTg+juT8Tox2urnyv5/0n
 oR9Gzw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fyj16u6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 00:50:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso7049653eec.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 17:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791507039; x=1792111839; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GRWH0yyKnT0v758YHnbtfFVpL80PTkKqdfh6mHGPiMI=;
 b=JvCxZCz/JANzDdVO3YdI7Ao7JrjcZJH7RiLYD6cEQ/vRv/hPhxQbNYY1KZAzeIEMIb
 RBtlDO1PPLFHzpc+JGNAIZ9OUSbwffcRtpNwdSGmDZs1zQ3p2ZdjZgNljC3O8SXjsMJD
 9jJGYdkBw4+5C6msy+FGjP3nk6MrZSeOMall3r2qSQe3o7cPEvJnRc0nNlyiM7b+DQ19
 tBzy+oNVL6s/BVh+YIJsUeANKKwET80JtBjnRncyq2HnjZPCAxJzYzb9WvehyLAI4buo
 VMxRti0ILj78U8v5909PhLHWXbfv+WRWrcvtEa/Oy7vz51cmmb03LouzA61OzVxVX+SF
 XlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791507039; x=1792111839;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GRWH0yyKnT0v758YHnbtfFVpL80PTkKqdfh6mHGPiMI=;
 b=2FkSm2DLmuMoQKTRVFE32Out2ufothRhfo7SudpyH5fJh1aO++j5hEekYrEKe+iSST
 VWVE6k2ezkmclKN5U+rtBdOURq4iiKF2hO80loMemk0ILZ3ex+KCHEONZfemfypLqLsX
 G8PxhJIoqKJgir4XD5RD9JSn3/mrhflnzcIdiDqQzQl6ekKcK5X77xy+nEk0Lwv7mo8l
 /y3h56GZ7G32Mr9FhIqE8wBLwKpgE+pqFlUqBoYMuO3qsvhAh3BdkhJEPrc8HbySd11S
 mU3VpnpA1MSRj0hmnNi11DzyKIi0+wIeuZ3JW/9kSFi1K2E/DAgvs0ZF+3Nf+uEzUZQ2
 ZWKg==
X-Gm-Message-State: AFuF++m97mj/Wsw30eIGdofq+qci1iMmEW9hbpxK1tej1rhNWpP41img
 8Vk0+3lgkcUNDvuUwR1yQune63YdbMf1uCEQbW5uZqBC0VZV99gR8RRdqrsv3q3x4L6jGYHczPJ
 Pw6TBdJeDOTjpyqG2DcAxlNGuKEe8rq6bOLCDnTuWgXnnKyHN4AQltG/DpT9EgR9Svg==
X-Gm-Gg: AYBFou3SYEq6ZjgNIryyyBpqfCNEeK+dO/vAToxe3bIq+AE+5X0x0bI8OVCOz8aE6Ob
 81enjaorEpch5WJevdJ1OfBf3pNjGYhhz8I4hEMyXoryg+qxcfdpsQ91EmkHjJTRqKCJ6NQw1+U
 qNSgvLY7+HJrWEh63ZEQjBRVvvY3mjkufiWCeqosm254mFdgzmm9Dm9qigGYfAAspROrfTcO3ks
 6tGTlTQsfWKp6jCCY2jkNrcw7/aqUd7R37Dch2s4WzscBZvYSc50SwOOGXEBcUvk3rsvnERea6t
 3uqL+hHPmqrN255jAFEZmLa2k5f58QH7ba3Jo36j+A0GnvFdDMqWY+k2H6C9qphwkaMoUXOP1q0
 1N/KpnaeoO13ea2xTJ4QWzTwIoC6XIreV5240iF7E62bL3vJroQB7C6Hj+TDK
X-Received: by 2002:a05:701b:4588:20b0:156:3684:96d4 with SMTP id
 a92af1059eb24-16a5cac06f7mr389480c88.25.1791507038533; 
 Thu, 08 Oct 2026 17:50:38 -0700 (PDT)
X-Received: by 2002:a05:701b:4588:20b0:156:3684:96d4 with SMTP id
 a92af1059eb24-16a5cac06f7mr389387c88.25.1791507036623; 
 Thu, 08 Oct 2026 17:50:36 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a4429603sm1604616c88.17.2026.10.08.17.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 17:50:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/2] gitlab-ci: enable slirp in the Windows cross-build
Date: Fri,  9 Oct 2026 00:50:17 +0000
Message-ID: <20261009005017.61989-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009005017.61989-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009005017.61989-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BfpNQbt2 c=1 sm=1 tr=0 ts=6ac83a5f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8
 a=VpQxruuoh7Pg-DnlwxoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: YtyXVd8czwqsc_BfzHcRyz6nyYlmx7Zn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwMyBTYWx0ZWRfX9AGABU+dXW7J
 +Y1Xp86KzJMAZrRWum8N4NHfofsSz7KmaBzVLzn3zHYuU16bLno+06nW99TbPCAQIJhcO9hAYYL
 9bhFHX7717a/18WNc4hS7xnolpLmN1IUfkl/G1Nv9dbi0V/aQV3NmJV6FL4ZVPxmh3EqjddBPti
 A4NgB8NkQJ/AIWFOxSkFhofk9DEmWDFYsS1XANR6jqU4BCZL8aCOlnPk7UpYl8EeSvT8HcXap3z
 ecnkSYflDPcnmTF1H32JbFGGnLW91REn8+HwJv/FhpKlqS8ZlvL54OUmbu514jBbsLSAxV0VRsu
 jmFshnna2/KgY1g+hejuBLN92ZpskK02lLZS1oDtiSJ45/ndBhXEwV0XTJ1s+zP1GZe/zFd98dP
 CtPeCYv1lRP59aLJi+bHBxIVnWo//IDMWelKcIAPM7PrxRmGvSWQVfbhI25VAFf21CkFYpzY7n+
 KnpBmtdcDcmu6wSSgPQ==
X-Proofpoint-GUID: YtyXVd8czwqsc_BfzHcRyz6nyYlmx7Zn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwMyBTYWx0ZWRfX+5FbLuXhASNr
 2hnMCnPSL3NuJWlOH8qIpyUMdZ0gtp7CVOqDO5PFk37O5Qzucnia/V1KUhhC3bJg3Sh523C3zPr
 yruOuuRLDSK+dYypQPp9sBQT7jKIHIg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090003
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

From: Yonggang Luo <luoyonggang@gmail.com>

Require libslirp so check-build compiles the PXE test and catches
MinGW portability failures instead of omitting the test.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261008184119.142-3-luoyonggang@gmail.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/crossbuilds.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index a823aaaa218..d5dc4946e92 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -95,7 +95,7 @@ cross-win64-system:
     - job: win64-fedora-cross-container
   variables:
     IMAGE: fedora-win64-cross
-    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal --disable-plugins
+    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal --disable-plugins --enable-slirp
     CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu
                         m68k-softmmu microblaze-softmmu
                         or1k-softmmu rx-softmmu sh4eb-softmmu sparc64-softmmu
-- 
2.43.0


