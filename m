Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3AECA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKyA-0000FJ-HL; Thu, 01 Oct 2026 13:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxm-00084h-T7
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxk-0001qB-3d
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:58 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691HUvmt2353174
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HmhCSOp9t1SvZWvmK3MAc2/WOAXT4/pIq9Nw4yvkT98=; b=JuFI+EZuA5EUyAPa
 ilDwzcvIequKt0Xr1kKAH6xtNPZJ/hIxGm+n2Sr2jbMJ/hPe9xR4o4q5dkN5RjT9
 GBbDB1C9JXEj+acylIoV39nw1evsIcWR5w1LZdg6MLtMtxttuvj/xiguOQmoOKLm
 rQH5E0yFb9iMf6KuG8/L/Yi9syB97x1a7kvA9HTygqwApQ7dnm59h8NweYCveTEZ
 Gzu4CTh+0gio+y168zahaWLpL4G8BSnk5tM4TBU1XCMSdziXLYKmm/0o1kYPOS2Q
 wxLQQjwDV9ANc5Q/NPg3NhvPYIsOUNQrJ5FE99n8I4LeFGmXLnNJaNcim2sYAH+g
 SGdaBA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1v0304qa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:44 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1466ab2bc8dso9221248c88.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877164; x=1791481964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HmhCSOp9t1SvZWvmK3MAc2/WOAXT4/pIq9Nw4yvkT98=;
 b=kYIhRGaV5DKS1hZCmsEgjenMn9NrprqovPvpUpstm8YVlL1QspQl3MeEq0SELD3mYa
 Ass5Lh4UwBvJz1pi89VcWtqPcoryvx0DpqHLwIE04QOppH0Hjud97IybBbhfsJdygm86
 DUVATOokyuRmosm6L6fTu2aGaSFBrTdsRh3B/nP1r0utXAgQQJXT9Uy14VCYIdNMXjoc
 Ev8qk+RthdYaurJ5qgxn7gekpugoWZMsoOyLy2CBygNaaLtvvJh02I3UDMyCuLt1Zpf9
 OgD4pdhKCxJpW6+qGiFYlFNsZ2CnLQktjaowxGZI8MnJQIfrV0x2jCAh1GWpYMuo/eiU
 hJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877164; x=1791481964;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HmhCSOp9t1SvZWvmK3MAc2/WOAXT4/pIq9Nw4yvkT98=;
 b=11BUBJu46J4Pl2mvzlajjPWKF2elGy87jxduoTM6oOZVSOdS2V7xFFAez0uNHMEV5j
 FdXKVTHY5mUGHVvdV0iCk8UDs+ZavBnG80ylm/v/Cb2vAD07p0qws6Oa/VNaME3tTK5Q
 bHXfodek6/zCzTgBojloT3KVI7VXWgSG4w1JqkYCcZYKYa9xRhy2nBvzeZhGJg75ugRK
 60IEShY3UDmJg1hv1AgQWS9IGrIjSLYTt318Y3eMKj5+ZRM7UsbPfP/QA/0Kdgwe9+lI
 YDIa17brDTeW254ud8usGaMJfHxZSAL+uw/z7Q6nN/UYwwfXw/SwPY8d22htLseqkEav
 v//g==
X-Gm-Message-State: AFuF++lVHeojBU8jjW2pbaBMqhxqDMKUKx+5SD8gqbp4MtWyQMFFmTFR
 IcGoIkWkT50xHk+p6G2/PJmdKXk/InSVbdr6Xgffevlnht6Q9XA8hxTAEVNtSy/JutgJIoC2+96
 zDpu7uZMSKeYT73/KoclSmy/ka6/lxXrLau9dDodmEYmj3tDQqyPVf+HFIiPVR3UAtA==
X-Gm-Gg: AYBFou2+8iz9qdIUEHtyzC3xs6w4zADfYW8t3+NQXSe4kaDK/EEGnkjbJWPjJPybwc/
 dT9i7zsRaF8n2CvMGvYEIJq+pzEr/rbHmImfK6c/r+P82U7fICiQY3EgcmaDGIjACVSKRYYhUct
 gIENobbmQFLFxv1Fms0laNwCU9714kpFxICjdnwyAHVIf109FY21T2fOyUPnvNkjYSkqv2qWXZQ
 RiByzyDLlMleI5XJucAkYIQmnANCqJ4bKnFvn3akeHUfPOXjNG+s1Lv2Q8afoDs+bhpub3cxz+l
 bgyrYduEHxcQmVH/cmLhIqTY1vEKWrvaUF7G4qBOD6cW7pihCwZmiZu8KXuR43WQPYnJvRXsQQO
 g9FSyo+vaTrCBzm/BrAcq13AQGb58m3EiL8gU7DTtSBOAPIATtGLqzz1775tZ
X-Received: by 2002:a05:701b:2052:20b0:149:50cb:2175 with SMTP id
 a92af1059eb24-14d32ec1ff1mr5551229c88.33.1790877163422; 
 Thu, 01 Oct 2026 10:52:43 -0700 (PDT)
X-Received: by 2002:a05:701b:2052:20b0:149:50cb:2175 with SMTP id
 a92af1059eb24-14d32ec1ff1mr5551182c88.33.1790877162696; 
 Thu, 01 Oct 2026 10:52:42 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 20/27] tests/tcg/mips: declare msa tests sources
Date: Thu,  1 Oct 2026 17:51:56 +0000
Message-ID: <20261001175203.8673-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX+x35kt9A+/b6
 Ei9Ho1MoMTeoCaBCGJaCTMTVXSuc+r7/SBRWU7pg0EdKFYWxNJ8ZbTgIW5JiPj34UzUItEM3ly7
 DYB5yCUslUsTxfZYN4HtHpmmcqD0pcU=
X-Authority-Analysis: v=2.4 cv=GqfXaU1C c=1 sm=1 tr=0 ts=6abe9ded cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=evm05GycqqZGmeajNGMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: o59ye9g-05p0CPVjk0IWM2meyO4kqtQw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX7LEzxUPnNyIP
 gs/u3bxVw9VyRSK0AF2gGXhBcaEzCKLXAezVLzozrb/xhtmKLx/P7JFSxKCuCWAzU3nlz9/lVc4
 QJhCy3IcX3fb9IWj+1E8TU3P2W3VC8qDG19tZQFPAHEweuYHUAvoNu9DnqUKHMJCVU/H7z/z++U
 zbyvrIMT1ZCY46y/vyFL04oV06EW3Pb0npaXi13NaCGh1mCyc5hhW9t1YLmERp+qbJxk8NutlNe
 IogEu3p20lbzImv6G2Xndgn89lhxWqIMsYJ7iWwNYR2LWdyGZ1HpsF2/JycveLynnLN3iFEjYm7
 JdwwfO75VbgE9fS8N2Z8RsZUMDDrraMUaZEenc0BypgGydyTW7QSPWoLPG22mEM5loIMwmWgl00
 F4X0kDw0L7tQtrxrhxKKbvlBNYS+8Ubmbi4mW5RpnP8e/+DjAEXLQ/U/LJKeWIXj9SJWQxqySmq
 t35RdfH6hORhoOOGVrA==
X-Proofpoint-ORIG-GUID: o59ye9g-05p0CPVjk0IWM2meyO4kqtQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010071
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

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-21-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/meson.build | 277 +++++++++++++++++++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index efda857ab61..2164f143ea8 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -22,3 +22,280 @@ if 'qemu-mips' in emulators
     }
   }
 endif
+
+tests_mips_msa = [
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subv_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subv_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subv_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subv_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmin_w.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmax_w.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmax_d.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmin_d.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_mulv_w.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_msubv_d.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_msubv_h.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_maddv_w.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_msubv_b.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_mulv_b.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_maddv_d.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_msubv_w.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_maddv_b.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_mulv_h.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_mulv_d.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_maddv_h.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_s_b.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_u_b.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_s_d.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_s_h.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_s_w.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_u_w.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_u_h.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_u_d.c',
+  '../mips/user/ase/msa/bit-count/test_msa_pcnt_h.c',
+  '../mips/user/ase/msa/bit-count/test_msa_pcnt_b.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nloc_h.c',
+  '../mips/user/ase/msa/bit-count/test_msa_pcnt_w.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nlzc_h.c',
+  '../mips/user/ase/msa/bit-count/test_msa_pcnt_d.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nloc_d.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nloc_w.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nloc_b.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nlzc_d.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nlzc_w.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nlzc_b.c',
+  '../mips/user/ase/msa/int-add/test_msa_addv_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_a_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_add_a_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_a_w.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_u_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_s_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_s_b.c',
+  '../mips/user/ase/msa/int-add/test_msa_addv_b.c',
+  '../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c',
+  '../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_a_b.c',
+  '../mips/user/ase/msa/int-add/test_msa_add_a_w.c',
+  '../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_add_a_b.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_s_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_u_b.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_a_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_s_w.c',
+  '../mips/user/ase/msa/int-add/test_msa_addv_w.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_u_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c',
+  '../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_addv_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_add_a_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_u_w.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvl_b.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvev_w.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvr_w.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvr_h.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvev_h.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvev_b.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvod_w.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvev_d.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvl_d.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvod_d.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvl_h.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvl_w.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvod_h.c',
+  '../mips/user/ase/msa/pack/test_msa_vshf_b.c',
+  '../mips/user/ase/msa/pack/test_msa_pckev_b.c',
+  '../mips/user/ase/msa/pack/test_msa_vshf_w.c',
+  '../mips/user/ase/msa/pack/test_msa_pckod_h.c',
+  '../mips/user/ase/msa/pack/test_msa_pckod_b.c',
+  '../mips/user/ase/msa/pack/test_msa_vshf_d.c',
+  '../mips/user/ase/msa/pack/test_msa_pckev_w.c',
+  '../mips/user/ase/msa/pack/test_msa_pckev_h.c',
+  '../mips/user/ase/msa/pack/test_msa_pckev_d.c',
+  '../mips/user/ase/msa/pack/test_msa_pckod_w.c',
+  '../mips/user/ase/msa/pack/test_msa_vshf_h.c',
+  '../mips/user/ase/msa/pack/test_msa_pckod_d.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsr_w.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsr_b.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsr_d.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsr_h.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsl_h.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsl_w.c',
+  '../mips/user/ase/msa/bit-move/test_msa_bmnz_v.c',
+  '../mips/user/ase/msa/bit-move/test_msa_bsel_v.c',
+  '../mips/user/ase/msa/bit-move/test_msa_bmz_v.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsl_d.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsl_b.c',
+  '../mips/user/ase/msa/shift/test_msa_sra_d.c',
+  '../mips/user/ase/msa/shift/test_msa_srl_b.c',
+  '../mips/user/ase/msa/shift/test_msa_srl_d.c',
+  '../mips/user/ase/msa/shift/test_msa_sll_b.c',
+  '../mips/user/ase/msa/shift/test_msa_sra_w.c',
+  '../mips/user/ase/msa/shift/test_msa_sra_h.c',
+  '../mips/user/ase/msa/shift/test_msa_srar_h.c',
+  '../mips/user/ase/msa/shift/test_msa_srlr_h.c',
+  '../mips/user/ase/msa/shift/test_msa_srl_h.c',
+  '../mips/user/ase/msa/shift/test_msa_sll_d.c',
+  '../mips/user/ase/msa/shift/test_msa_srl_w.c',
+  '../mips/user/ase/msa/shift/test_msa_srar_b.c',
+  '../mips/user/ase/msa/shift/test_msa_sll_w.c',
+  '../mips/user/ase/msa/shift/test_msa_sra_b.c',
+  '../mips/user/ase/msa/shift/test_msa_sll_h.c',
+  '../mips/user/ase/msa/shift/test_msa_srar_d.c',
+  '../mips/user/ase/msa/shift/test_msa_srlr_d.c',
+  '../mips/user/ase/msa/shift/test_msa_srar_w.c',
+  '../mips/user/ase/msa/shift/test_msa_srlr_b.c',
+  '../mips/user/ase/msa/shift/test_msa_srlr_w.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_u_d.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_s_h.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_u_w.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_s_h.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_u_b.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_s_d.c',
+  '../mips/user/ase/msa/int-compare/test_msa_ceq_w.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_s_w.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_s_w.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_u_w.c',
+  '../mips/user/ase/msa/int-compare/test_msa_ceq_h.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_s_b.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_s_b.c',
+  '../mips/user/ase/msa/int-compare/test_msa_ceq_b.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_u_h.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_u_h.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_s_d.c',
+  '../mips/user/ase/msa/int-compare/test_msa_ceq_d.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_u_b.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_u_d.c',
+  '../mips/user/ase/msa/logic/test_msa_or_v.c',
+  '../mips/user/ase/msa/logic/test_msa_nor_v.c',
+  '../mips/user/ase/msa/logic/test_msa_and_v.c',
+  '../mips/user/ase/msa/logic/test_msa_xor_v.c',
+  '../mips/user/ase/msa/move/test_msa_move_v.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_msub_q_w.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_msub_q_h.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_madd_q_h.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_madd_q_w.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_u_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_a_b.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_s_b.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_a_w.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_s_w.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_s_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_u_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_a_b.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_a_d.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_u_d.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_u_d.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_u_b.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_s_d.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_a_d.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_a_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_a_w.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_s_d.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_u_b.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_s_w.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_a_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_s_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_s_b.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_u_w.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_u_w.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_s_b.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_s_b.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_u_w.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_s_h.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_u_w.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_s_w.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_u_h.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_s_d.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_u_h.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_u_b.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_s_d.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_s_w.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_u_d.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_u_d.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_u_b.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_s_h.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bneg_b.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bclr_d.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bneg_h.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bset_h.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bclr_b.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bclr_h.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bneg_w.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bset_w.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bset_b.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bclr_w.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bset_d.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bneg_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c',
+]
-- 
2.43.0


