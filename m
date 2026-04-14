Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5F3F9D0FB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 22:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCmMn-0002hs-Dd; Tue, 14 Apr 2026 18:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wCmMj-0002gx-P6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 18:36:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wCmMg-00083j-F5
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 18:36:17 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EHvor53059023
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 22:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w2kRL8WYX/Xz2TKBYkukZcKpZiYYaxq8gTdzUUZCitQ=; b=KptE4w+PIwRFZv4E
 PdZEXjhM/q4DSz0msitTaa2A6XOebqh03LHvroTqiHKjk4CkOChnCcyehjDI9CXe
 bA+/aoVNTgKY+byG+bd3SZHDxksb/M91rP8yi4Ev5t8W3ROxoAmHmtmMkJSWEcEF
 pLUPGVkleAxDYBkTkE8raJXX6l4/F7EJl7xFRrny38WHqk6Qj3viwwcYW3z5C19I
 Qa5o1oApThYQPdCBLKhXayuKIrVZYwTX9PEzheWa2v30Nu3d0MC7vA6khg8tiLMi
 IKsHC9sEdud3x1JfKaR71GhPD4rbfW9wvUQjcr2Tn+whyERLz6GxlhIOXbhRXMNU
 T+bBjg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhteprs5p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 22:36:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2ec17dc21so33030445ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776206171; x=1776810971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w2kRL8WYX/Xz2TKBYkukZcKpZiYYaxq8gTdzUUZCitQ=;
 b=EI86OHAV4JkVPnKlZcl1XBEMeXDsdKG2z3ZFwMrM27+jm59Yv62sK467wmnCSE5nYU
 CiQaDbDHbzkUalBNxoDc3XF4K3tUtiotxh187FKOZ2vkLQzP15dfZJQKoMx6bIPwGZtz
 sbVJqwAzj8QGbTZKsQInH9KWj1mHJzd21isgphWp/dNzhP7aSgB1nKoYoy9YNAmKjI/n
 oMRw3RMBhkRSBNvRZeeXWW4XBGMVMF8qNNG3ovJZSRBPoRpSAGh2fGHetPfikPdUlbl7
 CxZz9jcGEdXx9fiJeiSkJ6i8RU+BcL7KIxgR+f6Ntj/EVZI7S/gOLambL4rflFTHgcfT
 Jhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776206171; x=1776810971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w2kRL8WYX/Xz2TKBYkukZcKpZiYYaxq8gTdzUUZCitQ=;
 b=klzD+0ckoWYhgEtpHeb6sH+CQTxnaRqBNQvolRqAwoMxrF2h6/qtNZ/027KXNU5XgP
 RnGU7QE3sUDtqMWCk9+9Opteck+OGJiPmT8POeSy681OvyYgjdQy3eEzbBeTzy0Xzf8a
 MaAqvvWBN6TkvFheYDHz5heKCX13nDwGASMq1knm/jCwM0S6slXJgr4tt2k0rxBINo2M
 sVAbnML6wLyZ05VaevVti3hiB1b6kTnQqbhTQjYcJqKGfUdpiIPBOUm570JjUGtDx9wt
 ZDgJqsrneRMM7h3mJfHYV19XKNBSoEh25FT/w/B90FkzniZ90KZsDM70Ivrgu+mquTcQ
 OtAQ==
X-Gm-Message-State: AOJu0YzU87kvSUU+vIWmdb5EjTpFoCik/y4sFDWPEZjBfgmCojYaSAtk
 kVadyMxTTZgYO9Kpba0Qp0kwvVxIRpN8RDH+vV9A9lgQka2HgCuOTSmjVKN7DtWi1S6lLVQKXRY
 qLELfuXVoSHww71r6zAy4ctIH4XYpXVNDj6coBTQcxNx6vle0Dj3Fr27RJjIiJIlQIKElWp8=
X-Gm-Gg: AeBDietKdHv8DDO5hL+Y/MCW8PSxsQsT/wKi+KrGd6RacbjauPGeRlVcS2n3ecs9+h0
 lH/U7XUib7Jjv7qGhn0vTjCC85xhYhQrZcO7oAieRraMjE0GifqZGmR/IgdivEbkOp9tbb9Jr0V
 dybg2R4jMumC106zLHzqFb7zlkNxciP3HY8D8se7IpDk6660ANYjVCjPxz0IG1dGp9/uFD7RoSw
 mlMLGZyj+MBijrcy3KAhQqBb/8wZbYZxwJ2zS11k+sI7SRFDgH1jQT9dyErEqB1uuTLyDrfrEtn
 vWBbGCTCpvfBpQYf5D3wUCJs/bjfz5SbXel6T+bxAV8mtGZ6svVn/q01GyUmQnR8RVb1A3VitZW
 P5dNPB1sBuY2yZYtiyzUBX96JJpelppBBgJgXdGARm2dTZjbuK9sgEz+Rfu4N1woyuUDcIoAxt2
 mmlu4=
X-Received: by 2002:a17:903:2c04:b0:2ae:c5fc:b2ef with SMTP id
 d9443c01a7336-2b2d5a558a4mr188127535ad.30.1776206171313; 
 Tue, 14 Apr 2026 15:36:11 -0700 (PDT)
X-Received: by 2002:a17:903:2c04:b0:2ae:c5fc:b2ef with SMTP id
 d9443c01a7336-2b2d5a558a4mr188127235ad.30.1776206170843; 
 Tue, 14 Apr 2026 15:36:10 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b46151801dsm68901025ad.78.2026.04.14.15.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 15:36:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/2] MAINTAINERS: update address
Date: Tue, 14 Apr 2026 15:36:02 -0700
Message-ID: <20260414223604.104290-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414223604.104290-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260414223604.104290-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DglV5HqtfnoCRknEO0hv_dCoC0tLoQ7H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDIxMSBTYWx0ZWRfXyz/d3ZAJlthG
 u/t59UI1pq30i7HsTtkARhX2sukjWCEgWHR8LkYgCndOVAhWB/NKDk1HQOhQf8UJaGSaAoZzoma
 5KnJqzJJ/PNyptfbsd7d4jADA8HH2xq2yJxddBEmJGuuCQ8uzVS8FIjNVNgIBUxrg769kmgqLXN
 TsuDwg2bEQ7aa3KV7ISaCgkhQ1X/gMVCeCez3E4DOP5f72j6VwgDW/d/yC5QKY/UImc/cR7Tp9R
 HcbMgITPIX/Q1EoRaen4JqNYZmyL56ZvzYQEi/LmL41zYqyw2G4Y3mxPvgOirvO65wtuwZUBR3x
 npHWeCK0BOjU3vccVwVOixsZkQVadEY/X6wM0jZi6OUE1tSESNURb54I7NLowop7lO8ou/Kv0zu
 0moCHkUATPbc7lpSvQW7+R2fkTpGgC21EidhYb4xzrUOByFeJ/DAz4NdldQEolXouc3Bz2fnuLv
 P64L9MKE45X2eLGXvMQ==
X-Authority-Analysis: v=2.4 cv=CoGPtH4D c=1 sm=1 tr=0 ts=69dec15c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=cplnpDx6AAAA:8 a=dGsWvjqBAAAA:8 a=pGLkceISAAAA:8 a=SqMvC5kiAAAA:8
 a=Xv82AFIBnWWXnF7l86oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=bHwCOBSOUrNypjIvOSWD:22
 a=EwAE0RQWx3bH85eTCWcH:22 a=_o8VnCo6Hb5Oqlm6Mk7M:22
X-Proofpoint-ORIG-GUID: DglV5HqtfnoCRknEO0hv_dCoC0tLoQ7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140211
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced84..14bd822ddbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2038,7 +2038,7 @@ F: tests/functional/generic/test_empty_cpu_model.py
 F: tests/unit/test-smp-parse.c
 
 TargetInfo API
-M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/qemu/target-info*.h
@@ -4075,7 +4075,7 @@ T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
 
 Linux user
 M: Laurent Vivier <laurent@vivier.eu>
-R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Odd Fixes
 F: linux-user/
 F: configs/targets/*linux-user.mak
@@ -4094,7 +4094,7 @@ F: include/tcg/
 
 TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
-M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 T: git https://gitlab.com/stsquad/qemu plugins/next
 R: Alexandre Iooss <erdnaxe@crans.org>
 R: Mahmoud Mandour <ma.mandourr@gmail.com>
@@ -4556,7 +4556,7 @@ L: devel@lists.libvirt.org
 F: docs/about/deprecated.rst
 
 General Documentation
-M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: docs/
 
-- 
2.47.3


