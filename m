Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81771D1CDAC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 23:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQwQ6-0008AU-Ty; Wed, 03 Dec 2025 18:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vQwQ4-0007xb-HN
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 18:38:00 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vQwQ2-0001Ne-9C
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 18:38:00 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3B4iiq2626940
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 23:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/FWx6Q46QeEDVQkccxnHj0Ne
 EdDoNb4gzX3iPx5fK2U=; b=R0v6GgzzqmsUhzKtut2/RnS95fnWWJ6iSyf8CXbr
 MWe728fyjpP02lv0CQ1a9Z8v81LBDK0DGTUutr9gZ4Wp+nefasr09qLhIZzJ6rjz
 fk1GwUKVbzF99Q6lHqTV8iwjcWOP4JO9imi6mqogjHEdI0Hdg4aTEJ+/f4QaH7Fl
 lQ9qpFAJ9bFV15FStBvEzyXOVBL0lScfVpGlXWhX45mGea0r5ki1DoCI21Qas7CT
 73bjfQfQhNNPuZ7v1v2RSQzBOWdhbnZx8VmhGumeCarCMCj7kBKMfk6Owk2tagAp
 8Scv7TIrXXNj3HKrcOAFlzkiWpHb/Ndgi7q95We0ppjXcA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atm12a0mp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 23:37:57 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7868061f373so4919947b3.2
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 15:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764805077; x=1765409877; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/FWx6Q46QeEDVQkccxnHj0NeEdDoNb4gzX3iPx5fK2U=;
 b=WD5mngdVrCm3zla/3Zynjg4vtlNYsAep8w/e1ESXzuRMnkC6iEDqcvUCRPv5nGn6Vu
 f7KAa7Psse70+BSH0lXBWlaApXimTW93zHUmOHrBL6PHut0Jc1fBtlIY1nk0H540383b
 IxruwJdV8sZaBNWCQ611t4e6PZrWJ6LRJzHJWCgHGO6dg64onVEMoCBzhWngIQS9DYho
 7Pu8OE8vsn9drhghkprqUaZmoh1kZPTJ2Irk4YJTvFUPelL1vnMVxtVb3n4kf313EioD
 Au/df9qyni96i/sts7e6c4F75ON+Zfp2wbwLRZguKtR4eHiIsdMoclBT4wu6Hhc3fys/
 y2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764805077; x=1765409877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FWx6Q46QeEDVQkccxnHj0NeEdDoNb4gzX3iPx5fK2U=;
 b=JhoQ+wigJb3J83EAeEiocCwJUwFxwzQHwpIjnkrikjJZp/EJKXXtQXweNztRyBAPQE
 htB7CVqEWAnoq6bOLlfQEpqvHLzoCPBT52PVCP/xPovVnH2JInVNkQWQSMD2+yZbMrag
 IuQ/qxH6x+uab8HRCLJh0KokT5d5SooyP+4lEMqONKT0G4kP7ot8zo+KCiOc3FfNAOfC
 nc/1oYIX/2AQ7GfJiaMpIf+YD1i92rCvFuDHMxFJbaMVrha/Otf89iaEq+0uFg56s0io
 M5qTTW3R8AQoA9hDslARI318XzDu4E1vxxC0qbLLlp6H9qwYkFbIKY13/buGxIF7hhGa
 /ZEg==
X-Gm-Message-State: AOJu0YyWjsQGc04qzdw2ktZV1y9gr8CHP7sfA0W4tE3PnjC+1jnoSQdK
 i3Xc5M3ShU+78lpQzG45kSpi5tOOg/VusAkeGKV7s0Yaa0tKgv0b+lGOuKxOJKfVXWDxnSf433o
 8lXeo/VYA9Djp3xWho8HYqG8g9DRRhkOySlfxB+RU+wP+RhSTqyRbdNaqlb/bkFEuKzil8idveg
 /Pp3cC/NbzGmZl2yR3kC+HAp3kgVumtfSz
X-Gm-Gg: ASbGncuXjbyWkNFBe68H665bOYcyhsitlOj9bvsFkdgZPjyubKfBgPuysIv6LTjnsku
 DlOnZmT9/D0rAkZXIrogbI3JrzwRlzuzwGx1i8z8QnwFd7cjLeWKO8PSYX+zoMeOfvj4ZotQlQo
 iLDvcRyibQMUFIG1aZv0kUqFpRZH1JdFj1JMX6F3RRSNsxfyTaOV4HXVvqv70qYL8xt8zDysDbo
 F8+O+hkSJZePIzT5T3CjdmzUV0=
X-Received: by 2002:a05:690c:250a:b0:786:5499:6341 with SMTP id
 00721157ae682-78c188c8105mr8156097b3.43.1764805076758; 
 Wed, 03 Dec 2025 15:37:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg1Uxl00k+KqSTwwifB4a+kBeCjorfl/7O2Qe7DNpFItj5J3atgeXo5uyXajoHutxXe/UzhYOF187Yav7kp0w=
X-Received: by 2002:a05:690c:250a:b0:786:5499:6341 with SMTP id
 00721157ae682-78c188c8105mr8155937b3.43.1764805076377; Wed, 03 Dec 2025
 15:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
 <20251114230013.158098-5-ltaylorsimpson@gmail.com>
In-Reply-To: <20251114230013.158098-5-ltaylorsimpson@gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 3 Dec 2025 17:37:44 -0600
X-Gm-Features: AWmQ_bkeHkVeB7L_7J46HM457KRVdMRtUK9XWnqVZvl-hJLOTREyuDXej07q-uo
Message-ID: <CAEqNhNZMCPUETJ68bu8WU4WoPR=UDi+FL3uVsO-kiDkdWpNO4w@mail.gmail.com>
Subject: Re: [PATCH 4/4] Hexagon (target/hexagon) s/log_write/gen_write
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000acf033064514b31c"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE4OCBTYWx0ZWRfX3tWnJMiiFnOQ
 55HR1LYxdBti177N03K0dKJuKvnKg00Q9bceUooWo8He5iOM28G4btKWPjnMHBtSWxgDUyoMqU/
 b4bj5cl8DIk6ZQEnMuH8XTsKMWhS+Df43p23B5xISJOl3MNwCI7s7dRhA9jPRvkti9+jH1GXhpb
 xVUHH5766bet3CQnUU5Nij9M/b8ihtAUkXr3gvo5jaBLkoAnVvlK0iRq0Bzadh9ZoKGnAeJRARd
 gOaoJIRVQ2c3P18+/WOmlFRojyzl4k4KQ0/u7xNwLzCxbbQhQWWqjcs5NH1rRCliyYastrnX1XI
 lGb16tk9JMpBGG6MfGTPESSW4I6IZ85T/flAwtsw5AAkmxWMLAQsrxRXl9FbugtyoIMTnyu7eFV
 ChXMUzcBOsOY9aDW7DCG2snCbuGkZw==
X-Authority-Analysis: v=2.4 cv=JY6xbEKV c=1 sm=1 tr=0 ts=6930c9d5 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=ehkT4voH7CEKph4IKWoA:9 a=QEXdDO2ut3YA:10 a=Gx6MGIrKwwK5PYX24y8A:9
 a=hxvYHQjkc5zOpndp:21 a=lqcHg5cX4UMA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-GUID: kBbf_ggFKuima7wDGz-oN7GH68ENpRo7
X-Proofpoint-ORIG-GUID: kBbf_ggFKuima7wDGz-oN7GH68ENpRo7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_03,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030188
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000acf033064514b31c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 5:00=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com>
wrote:

> These functions don't "log" anything, they just generate the write
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/gen_tcg_funcs.py |  2 +-
>  target/hexagon/hex_common.py    | 30 +++++++++++++++---------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
>
>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>



> diff --git a/target/hexagon/gen_tcg_funcs.py
> b/target/hexagon/gen_tcg_funcs.py
> index bd241afde1..3e531bd540 100755
> --- a/target/hexagon/gen_tcg_funcs.py
> +++ b/target/hexagon/gen_tcg_funcs.py
> @@ -94,7 +94,7 @@ def gen_tcg_func(f, tag, regs, imms):
>      for regtype, regid in regs:
>          reg =3D hex_common.get_register(tag, regtype, regid)
>          if reg.is_written():
> -            reg.log_write(f, tag)
> +            reg.gen_write(f, tag)
>
>      f.write("}\n\n")
>
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index 6b683487bc..c0e9f26aeb 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -451,7 +451,7 @@ def decl_tcg(self, f, tag, regno):
>          f.write(code_fmt(f"""\
>              TCGv {self.reg_tcg()} =3D get_result_gpr(ctx, {self.reg_num}=
);
>          """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          ## No write needed
>          return
>      def analyze_write(self, f, tag, regno):
> @@ -494,7 +494,7 @@ def decl_tcg(self, f, tag, regno):
>              f.write(code_fmt(f"""\
>                  tcg_gen_mov_tl({self.reg_tcg()}, hex_gpr[{self.reg_num}]=
);
>              """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          ## No write needed
>          return
>      def analyze_read(self, f, regno):
> @@ -517,7 +517,7 @@ def decl_tcg(self, f, tag, regno):
>          f.write(code_fmt(f"""\
>              TCGv {self.reg_tcg()} =3D get_result_gpr(ctx, {self.reg_num}=
);
>          """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          f.write(code_fmt(f"""\
>              gen_write_ctrl_reg(ctx, {self.reg_num}, {self.reg_tcg()});
>          """))
> @@ -569,7 +569,7 @@ def decl_tcg(self, f, tag, regno):
>          f.write(code_fmt(f"""\
>              TCGv {self.reg_tcg()} =3D tcg_temp_new();
>          """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          f.write(code_fmt(f"""\
>              gen_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
>          """))
> @@ -606,7 +606,7 @@ def decl_tcg(self, f, tag, regno):
>              TCGv {self.reg_tcg()} =3D tcg_temp_new();
>              tcg_gen_mov_tl({self.reg_tcg()}, hex_pred[{self.reg_num}]);
>          """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          f.write(code_fmt(f"""\
>              gen_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
>          """))
> @@ -626,7 +626,7 @@ def decl_tcg(self, f, tag, regno):
>              TCGv_i64 {self.reg_tcg()} =3D
>                  get_result_gpr_pair(ctx, {self.reg_num});
>          """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          f.write(code_fmt(f"""\
>              gen_write_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
>          """))
> @@ -660,7 +660,7 @@ def decl_tcg(self, f, tag, regno):
>                                     hex_gpr[{self.reg_num}],
>                                     hex_gpr[{self.reg_num} + 1]);
>          """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          f.write(code_fmt(f"""\
>              gen_write_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
>          """))
> @@ -685,7 +685,7 @@ def decl_tcg(self, f, tag, regno):
>              TCGv_i64 {self.reg_tcg()} =3D
>                  get_result_gpr_pair(ctx, {self.reg_num});
>          """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          f.write(code_fmt(f"""\
>              gen_write_ctrl_reg_pair(ctx, {self.reg_num},
> {self.reg_tcg()});
>          """))
> @@ -723,7 +723,7 @@ def decl_tcg(self, f, tag, regno):
>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env,
> {self.hvx_off()});
>              """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          pass
>      def helper_hvx_desc(self, f):
>          f.write(code_fmt(f"""\
> @@ -789,7 +789,7 @@ def decl_tcg(self, f, tag, regno):
>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env,
> {self.hvx_off()});
>              """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          pass
>      def helper_hvx_desc(self, f):
>          f.write(code_fmt(f"""\
> @@ -821,7 +821,7 @@ def decl_tcg(self, f, tag, regno):
>                                   vreg_src_off(ctx, {self.reg_num}),
>                                   sizeof(MMVector), sizeof(MMVector));
>              """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          f.write(code_fmt(f"""\
>              gen_vreg_write(ctx, {self.hvx_off()}, {self.reg_num},
>                             {hvx_newv(tag)});
> @@ -854,7 +854,7 @@ def decl_tcg(self, f, tag, regno):
>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env,
> {self.hvx_off()});
>              """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          pass
>      def helper_hvx_desc(self, f):
>          f.write(code_fmt(f"""\
> @@ -913,7 +913,7 @@ def decl_tcg(self, f, tag, regno):
>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env,
> {self.hvx_off()});
>              """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          f.write(code_fmt(f"""\
>              gen_vreg_write_pair(ctx, {self.hvx_off()}, {self.reg_num},
>                                  {hvx_newv(tag)});
> @@ -946,7 +946,7 @@ def decl_tcg(self, f, tag, regno):
>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env,
> {self.hvx_off()});
>              """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          pass
>      def helper_hvx_desc(self, f):
>          f.write(code_fmt(f"""\
> @@ -993,7 +993,7 @@ def decl_tcg(self, f, tag, regno):
>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env,
> {self.hvx_off()});
>              """))
> -    def log_write(self, f, tag):
> +    def gen_write(self, f, tag):
>          pass
>      def helper_hvx_desc(self, f):
>          f.write(code_fmt(f"""\
> --
> 2.43.0
>
>

--000000000000acf033064514b31c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 14,=
 2025 at 5:00=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpso=
n@gmail.com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">These functions don&#39;t &quot;log&qu=
ot; anything, they just generate the write<br>
<br>
Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.co=
m" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/gen_tcg_funcs.py |=C2=A0 2 +-<br>
=C2=A0target/hexagon/hex_common.py=C2=A0 =C2=A0 | 30 +++++++++++++++-------=
--------<br>
=C2=A02 files changed, 16 insertions(+), 16 deletions(-)<br>
<br></blockquote><div><br></div><div><div>Reviewed-by: Brian Cain &lt;<a hr=
ef=3D"mailto:brian.cain@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&g=
t;</div><br class=3D"gmail-Apple-interchange-newline"></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs=
.py<br>
index bd241afde1..3e531bd540 100755<br>
--- a/target/hexagon/gen_tcg_funcs.py<br>
+++ b/target/hexagon/gen_tcg_funcs.py<br>
@@ -94,7 +94,7 @@ def gen_tcg_func(f, tag, regs, imms):<br>
=C2=A0 =C2=A0 =C2=A0for regtype, regid in regs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D hex_common.get_register(tag, regt=
ype, regid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if reg.is_written():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg.log_write(f, tag)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg.gen_write(f, tag)<br>
<br>
=C2=A0 =C2=A0 =C2=A0f.write(&quot;}\n\n&quot;)<br>
<br>
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py<br=
>
index 6b683487bc..c0e9f26aeb 100755<br>
--- a/target/hexagon/hex_common.py<br>
+++ b/target/hexagon/hex_common.py<br>
@@ -451,7 +451,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv {self.reg_tcg()} =3D g=
et_result_gpr(ctx, {self.reg_num});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0## No write needed<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0def analyze_write(self, f, tag, regno):<br>
@@ -494,7 +494,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&qu=
ot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_mov_t=
l({self.reg_tcg()}, hex_gpr[{self.reg_num}]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0## No write needed<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0def analyze_read(self, f, regno):<br>
@@ -517,7 +517,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv {self.reg_tcg()} =3D g=
et_result_gpr(ctx, {self.reg_num});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_write_ctrl_reg(ctx, {se=
lf.reg_num}, {self.reg_tcg()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
@@ -569,7 +569,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv {self.reg_tcg()} =3D t=
cg_temp_new();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_pred_write(ctx, {self.r=
eg_num}, {self.reg_tcg()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
@@ -606,7 +606,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv {self.reg_tcg()} =3D t=
cg_temp_new();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_mov_tl({self.reg_tc=
g()}, hex_pred[{self.reg_num}]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_pred_write(ctx, {self.r=
eg_num}, {self.reg_tcg()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
@@ -626,7 +626,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i64 {self.reg_tcg()} =
=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_result_gp=
r_pair(ctx, {self.reg_num});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_write_reg_pair(ctx, {se=
lf.reg_num}, {self.reg_tcg()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
@@ -660,7 +660,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hex_gpr[{self.reg_num}=
],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hex_gpr[{self.reg_num}=
 + 1]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_write_reg_pair(ctx, {se=
lf.reg_num}, {self.reg_tcg()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
@@ -685,7 +685,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i64 {self.reg_tcg()} =
=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_result_gp=
r_pair(ctx, {self.reg_num});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_write_ctrl_reg_pair(ctx=
, {self.reg_num}, {self.reg_tcg()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
@@ -723,7 +723,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_ptr {sel=
f.reg_tcg()} =3D tcg_temp_new_ptr();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_=
ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0def helper_hvx_desc(self, f):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
@@ -789,7 +789,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_ptr {sel=
f.reg_tcg()} =3D tcg_temp_new_ptr();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_=
ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0def helper_hvx_desc(self, f):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
@@ -821,7 +821,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vreg_src_off(ctx, {self.reg_n=
um}),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(MMVector), sizeof(MMVe=
ctor));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_vreg_write(ctx, {self.h=
vx_off()}, {self.reg_num},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 {hvx_newv(tag)});<br>
@@ -854,7 +854,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_ptr {sel=
f.reg_tcg()} =3D tcg_temp_new_ptr();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_=
ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0def helper_hvx_desc(self, f):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
@@ -913,7 +913,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_ptr {sel=
f.reg_tcg()} =3D tcg_temp_new_ptr();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_=
ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_vreg_write_pair(ctx, {s=
elf.hvx_off()}, {self.reg_num},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{hvx_newv(tag)});<br>
@@ -946,7 +946,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_ptr {sel=
f.reg_tcg()} =3D tcg_temp_new_ptr();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_=
ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0def helper_hvx_desc(self, f):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
@@ -993,7 +993,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_ptr {sel=
f.reg_tcg()} =3D tcg_temp_new_ptr();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_=
ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
-=C2=A0 =C2=A0 def log_write(self, f, tag):<br>
+=C2=A0 =C2=A0 def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0def helper_hvx_desc(self, f):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000acf033064514b31c--

