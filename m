Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63058C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziRg-0003bv-8a; Thu, 27 Aug 2026 18:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRN-0002Qu-V4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRM-00078u-Ce
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:21 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM4m2849150
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fr7MXuQrc1i4cL+zV+WsxBIJSHsVIBvUZ5NQFGRvg7w=; b=gwkHMaXwtiQFa9z5
 uZ8oQtdVseMJsFaDNzIf3XPA6H/w2ldYvJp8mm+0zaenpblFKFjtBoi1XAcNr3Ac
 h9Q8r30TUyt+/x9N1Rz5hy7Gj5fQM89ZgtMcb+Jk1iVDjm9lUUllBD1GLJ0pT8g5
 4Gq/S79fSwa12fs7AZa9UAEVhGLp7yvXjZQdXMz3Kw6iiTX7IQAcSxFM52MVmdVV
 0P7LYftHkZFtRL2F9rd+K4jcQ8Dx0Ymb/0l9fM4GZU9nOgW3FLxVhVo/j4/gJjfO
 SkgtLDLK/BNS55z/93XFb2nKSXNfpxfPo1X/PXIOuPm2ua33N5xm/yS1zed0JDsn
 TvjbOg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a7f4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso857230a91.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869157; x=1788473957; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fr7MXuQrc1i4cL+zV+WsxBIJSHsVIBvUZ5NQFGRvg7w=;
 b=Rez61UnhyoQQAWtLnRFMcXizj5ELXSEQ5KUYaX5wW8bI9SpcOlxXB00woUVFnl4hcC
 VIdNvTtQzCUgA629n+ulQkyE3Ck7QBZ0VHp53OGI7FApAH7ildEgYWgAv/GMxQmUgcn8
 T7O3ZavDc3phpVzZqXNsLI6UkO7Gf8u6WWnm0Y590+HFJaP4WKvz643GmoflK4HknaDo
 QhINECxnKD1t4dgxW0hEzVEZmEFo2GAv8Kh85rbTrjGP+dqdLqA9x9O4jOcDxXIy9spe
 ku9ZobnbklMwVNo5RsWPg80Ak1nc4GJ98Sfb5Rt67j1EO1j6N1IEMmp945R/1IpVyPgr
 Zr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869157; x=1788473957;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fr7MXuQrc1i4cL+zV+WsxBIJSHsVIBvUZ5NQFGRvg7w=;
 b=jRILeDTOXtOovq6aRp03Npoyq5n5JVRWx91V2D4XYFgaakJtvLAKXTQqgz2nM7G91X
 dc3EyJeFc94KmTcbN64rZ3IsM3vncR9oc5gLzf91/ZIxkqHu8h6hRNZleaXFEN/eZq8y
 rDxDo94jYA5LwcjBxcxfdxEhPWkhz2QHyaxqxV2ldBxxOrLiUR5GV1nYv4iXV4M3QKTe
 35Qk/afPktEgr2Jmj9KBvst47a8uzzeQm8KiAPdXS3hAKuN1ks1V6/3T546VTPatQne1
 +QC85NhNhYTufi2SQjvThCHeDanLe5xSnrLFv1msH1SLCyejtgnVfnCs9vEe3CxZQ3zO
 ER1A==
X-Gm-Message-State: AFuF++lXJNhEKBV12+44W4gPE7UMCbuoSvVjJQbCOp2JMWH9fMFpmIaF
 d9gL4cAYPo3hcJ4ej8sXIHQkD8H3PJk03bR/zEL7gwEL4sgFeCq3vGtAMgG1P/Y3BMuJAjho2OL
 yjK9lkV9POsTyq0qC0991adKRADKJbl0XNnCQ0d4yFnCmYetT2O3qPqdxTGgAwIJmjw==
X-Gm-Gg: AR+sD11rMGMYnYmlECSG7Bee/W1WLLhRm8vQgqJhPTG01aWjf3QgVLkRxAUEbcyPUin
 jLJg14L/GCqkl+5pMSGt9Ww3tF2fZu+62kY8htWCSTHZJRgrG+eKBX3CttsKC4ry8IqCBoRHsYn
 BjURREMa6egVi+/g6RWPo4p6+WN/uACK0KaKwJikSFPvdKu6FlvH8XpZa5ktZKJEM8qs4LQIog/
 xAcrWPw/JDIXCNXREmfJHVIHSbFvTaZr8EyOMLkNtVi2kmqr+oDS1XI8pIbifyp5e5vRbk2aW3k
 /8M3VOT7vRfjwWEal8u0Fubg1Eet7xz1EUXWx/Gl1Y358XzUi/IOIIqHmWLRiUTQqtPGCFbcL6T
 yLkLU67c8lsBOopOKp0PJBLtcwtZp9d754t0+DPIrxI4kzqfoFi0FbLl9uLo=
X-Received: by 2002:a17:90b:5249:b0:396:40e6:f631 with SMTP id
 98e67ed59e1d1-396d0e306e0mr4683140a91.3.1787869157585; 
 Thu, 27 Aug 2026 15:19:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5249:b0:396:40e6:f631 with SMTP id
 98e67ed59e1d1-396d0e306e0mr4683038a91.3.1787869157167; 
 Thu, 27 Aug 2026 15:19:17 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v8 051/105] tests/tcg/multiarch/sha1.c: fix big endian
 implementation
Date: Thu, 27 Aug 2026 22:14:12 +0000
Message-ID: <20260827221506.91574-52-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX+AeQKYJPJfEx
 JpMLIjqf0dFj5X9bXgJPZFWLUD3ILoD9Trer702z1coMLw7FPcoRY4axNju6tpBiMTsATrdUhSf
 w37ef4MIFFTgSb9okVXFiLT/lk0Z9MeUL23Z7yR/TL/MMOnRlcLCsL8sDt6ZbPXSvelCmBtmxO4
 i3/GMGmXwyXHwIip9vEHu2UKjTpDONNWoPUuDylXE1wtYaGBOa9b9kSBG9lI646Ho4KfQO6gnvC
 LTdO758eu4RD8gN6lUcE8fPGHnVLaHxpj4ygiiJmDghysbCXByFoYink2EpUwwuPrAD4xbbKOU5
 TkK+hJ4sAbb5k/fO9DzQrBXnk7ynz28yaGIOWDYPXwJ8pHT4iwv9USoC3Vj5A4XkMIURleiutR/
 Ln9SDarfzEyIB6cxuU6PiQUIVf2RsoOIRiv/0rT01Bfj9ZTvIsboB9DlYFgvTsc4dKup92v1h+p
 Y+Z3UUVKu0PUM04UBIA==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90b7e6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=rodC9k6DH4pmb89SaOYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: TYHkokocLQeA0uVqkgGv5uheuMLGFORI
X-Proofpoint-ORIG-GUID: TYHkokocLQeA0uVqkgGv5uheuMLGFORI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXxjERzYhjDdi7
 kmyZp0xP5if5UOeUfQtnpy+cXDCf1MN/o3m5lOCocHiERFuRD5O1cr14nZLWg23LYuWMa/FQThn
 aiyeOTdICR4JpJUP+RO0vY7TQnXUpq4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Due to missing endian.h header, BYTE_ORDER, LITTLE_ENDIAN and BIG_ENDIAN
were undefined. Thus, for following code, the first branch was always
taken:
 #if BYTE_ORDER == LITTLE_ENDIAN
 #define blk0(i) (block->l[i] = (rol(block->l[i],24)&0xFF00FF00) \
     |(rol(block->l[i],8)&0x00FF00FF))
 #elif BYTE_ORDER == BIG_ENDIAN
 ...

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/sha1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/multiarch/sha1.c b/tests/tcg/multiarch/sha1.c
index 0081bd76577..0fcbc3ed605 100644
--- a/tests/tcg/multiarch/sha1.c
+++ b/tests/tcg/multiarch/sha1.c
@@ -21,6 +21,7 @@ A million repetitions of "a"
 
 #define SHA1HANDSOFF
 
+#include <endian.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdint.h>
-- 
2.43.0


