Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68821CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBytk-00021C-IH; Wed, 30 Sep 2026 14:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xByti-00020d-AS
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:19:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xBytg-0004EV-FS
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:19:18 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHej5C4160515
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 18:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xEcdHh0kijlBZ1/LtT078dArB4vYOGjCBwXl2ZRbbhQ=; b=J6jdMFT+fSCYlob2
 rbU244Q2gQ/4b95CyNxqfvUb69tuMDw/aMoKuOlooyUZz4SQN4KoSpCkHHsEEA5j
 CDORfrpC62eYA2pLUxKjM0si3+EbPt9H4nP4vEJ+tTyvCp9A2pzjQZS5h8zm//xd
 P0NicrxVRGAmTZ1FHqDfGXWnCajz/028K6gpL05gjFUufTa8u6md16/gkkgLrItC
 hKrMOVH1h3O8xs+zY9DFlF7VfBU6nIqFCX+cNfMso+hdHLDL71nv4ohhc3LpYn/G
 vo4YakvSI9lXAouXIb8T83VlDkT1OLXc9xfIHtB3l5fnZ5+oo7n/Md2DbDLkSrDP
 wG0Grw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pgf57-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 18:19:13 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4b26d8d2498so8856884b6e.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 11:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790792353; cv=none;
 d=google.com; s=arc-20260327;
 b=Hl9yaiPlbwDpXrZPHES0rQCQ4ZBBUmlZEEh18J6a9cbGK2eKD7GNsOdrdkLesh9Yio
 Hs/577W6XtiJrW/AkIYJxzxFseMNIVw/vlRuq64TfkQXOzKyyRYClhIoEn3XEq63OgWM
 enm9VyV2f+3FwNOwXx3Ojv/UyyJv4Sr44Bbwn7e7NgZCIAK70fGCEcY2nARbshj9+0il
 D/zVFrQsqgLox50nzOe9SKaWUByunbwyADsYjXara6miV4Luz5dtoJxZqSmounTu1cpR
 56AD7+j3ZyBPzuGkUi1btsx/PxlfGeown4tCiypdOI7ZaRCAPWoUVugwVQWm9CVdTdR5
 x/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xEcdHh0kijlBZ1/LtT078dArB4vYOGjCBwXl2ZRbbhQ=;
 fh=11nfX6Do8EaL1FMi+r6eKWxDDoA7QEpVbFRn3KjheFE=;
 b=DkgbIIX5JuhLf4vRey0Jwpa1q+LgMev83xqTrK4JqmXfadA758It67c6oobPhkY2Oj
 7Pw7S7eDigXo33OMwN98TUNkl6AVFN/UWldfCRvEb8WOoXFhW406Wbwt+mOIRSK2OkW7
 tqdTW4pQtkcDt/oatGGSZFTsHd4hWeEEEoWsXFmcoF2ualjNRNaodklirZwgGMluAuFc
 mYa3uGzCIL0qUrw+eOp/VVZUbT4XCzJlCv9ruizUyrf94FcDag43L7ZBoiG49VzPiVN0
 6rU0VVYeyo/e47DuRiqblJNWJir2hoRfhRx2rb90ncJLZWM5h5+FdHwvWDZroyvACZ/V
 gZmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790792353; x=1791397153; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xEcdHh0kijlBZ1/LtT078dArB4vYOGjCBwXl2ZRbbhQ=;
 b=RZdih1Uent94CCwodQMTWpFZJkC/wD0txi/lHKzKga39rxB+Xw7y1fcFbgToxNUgtD
 7eG0hbjHrjgQUtlHZwqhEeBsxA6sYrZ7vMd15I7aVAnH4n5T4mirCBaRPklR3jQ8qzzW
 6g8/9sVsLrTLH4/KVTJTQtowEVyoOrjg8+FRVQQOq+GQ3gQgbBQW+s3DZcgA6wq4mbNM
 wnoa9ORHWOj6dMrUVeiWg1DdWnlduFlFODXm1CELSpUQ9TMyf66fbuLrjeRtAO8JFA6r
 T1CB+dKYXafV1WvnFm4yMOYiWViEtW4/r8WwiCtJIIGlYrpJlYZKZ9JuTLd82AqxUMQa
 nerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790792353; x=1791397153;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xEcdHh0kijlBZ1/LtT078dArB4vYOGjCBwXl2ZRbbhQ=;
 b=p2/tuYCRRmUwIJdmBA0DDLc3mztYHYQ13ujRFGiZAo4z1YCbXhxcuC/KdLrKkHZDD1
 rYRKTQZFYYucuzqNMWP2n6m8eWc1c/fzwdVSSKf/5xdAjPdjLkvf+TmD/0nOsCqV6BRl
 JwpV5MPocH9lr7f2scCT6f5yadRuRpkLEhuwHsqEmQ4KmFlFo8FB8hWDNyzRLQJnjYXt
 P9JP+zZaOdQJGdVh6P1l30GT4d9G7avYwWppkXWD6t1nlrhGUD88UoUku0WcRPG7wC8W
 aXg/FDZ6Q0QTqP1GcTsTvPb3jxCegtTosHc4wJGmLRt+E/MmeWgDdeXMiTPyiE6COWGU
 8Elw==
X-Gm-Message-State: AFuF++lkal42p8Yu5VV/t614Rl8y4daAOCVaf6opT+B0Zj0gt3HVU/yS
 bqFoo9gtHMwpQp9zBvfJWYe3wZeQagk1fb69HFcxBvnR682UYQyC0O1fMhTpB5Mey/9WI1mUlLM
 tP5Q/zk9AeM+bQeFBwFxkb4rE+KilbnZ82DgbqtoaYotNzVQ8+gPj5Hdb5OlcIOuL4Pbc/sUVjv
 pHuP9mTevbuZ+xwECLYA0uajBn1+nYINDT
X-Gm-Gg: AYBFou113J6YFkt0PXSeVe94q+YjwEr/lQpwaWhY/7JJPtJXfeJwpXDBC/RGTj7THVO
 gIKdvu8UZxMNNz+4SveTxphOTyNABGidHPo7ihxPH8w/s2eVBqzJPRlISM51rz6AcKa8btQVUz7
 PEXLEnRH8nE0pPlkFFkZ0wdN/th8uAvrMyqDHC53jHworPUAK/b2YEwNTMYD5v3uc6hv4shFBtD
 KvjI18W0l179OE+pw==
X-Received: by 2002:a05:6808:319b:b0:4d5:27da:a492 with SMTP id
 5614622812f47-4f1b9a4cc54mr2192619b6e.44.1790792352523; 
 Wed, 30 Sep 2026 11:19:12 -0700 (PDT)
X-Received: by 2002:a05:6808:319b:b0:4d5:27da:a492 with SMTP id
 5614622812f47-4f1b9a4cc54mr2192577b6e.44.1790792351895; Wed, 30 Sep 2026
 11:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260926192338.2702952-7-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 13:19:00 -0500
X-Gm-Features: AclHuK_mxH4xPjZxpF5RchCH3ZJ0lMe-DjH1vjoBjwp02P2-e4SQg7pmzXOZFIw
Message-ID: <CAJ+KCYP4jViUrM0M-EktGgDj=wHaK-vnmBZ1dOfJzhH7KZjF=w@mail.gmail.com>
Subject: Re: [PATCH 06/10] target/hexagon: reserve internal HVX vector state
 for QFloat
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: eJrQM_VsJy2LIqVOYahZqjsc2xu3r1nJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3NSBTYWx0ZWRfX/MwxklmgAD7W
 oGsVS/9JlfN4rSol7s/qy9buB6PjAeefFR9VgeTGnKLO+XLHLgj8yADGRmfq+TA9BDl/BJHwiyI
 VdSnm98Fwv0eSc8ZV3tSKwkqHxIjRQ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3NSBTYWx0ZWRfX3EfngaCYhFug
 5VWo/OPGz69O9lcOlEVcVl6a5qZvUbQuWDIjc55V6uMkgJixk1emcRlRXfQy2ePnGx5I9XQgr50
 FfEcVLVlN730mFxHdn19Po3vPK0k3JIojzEn3tS6IhqjKqOSCpIDEb2dzgWtIjiKsSV7HilayHA
 zcsdPyxUbg/lxbciiTB51HeUzdjsH2/LQrkH3wFxH6Yel9eFAOdw0nxKbwpNfBmDgUOZ590nzHu
 lvaFdzeDqQT5/eg3iEHUs9W40HE5ltLTpkINWTQ3OsIpdEX56Eqd8ikr29F+7iuguayo04J1DPC
 ZdSNhTSD5QmQGPLCE5EGepdi/7Wg6azROgsXnw5XiPhcROVdYNMU3nCPLGV5FeBYFw585d8vHrd
 X/k17sCIgIyjD58YghXPwF8vzA1i2ptd8jhAWtQSJLtPi9Ut2CRBpSE5KvM7uG5zNt3F8sEtJK0
 skH7cgwBIO429h/ZkZQ==
X-Proofpoint-GUID: eJrQM_VsJy2LIqVOYahZqjsc2xu3r1nJ
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abd52a1 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=nMl2p6oiNZAOWJzd5FoA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300075
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Sat, Sep 26, 2026 at 2:23=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/mmvec.h     | 55 ++++++++++++++++++++------------
>  hw/hexagon/hexagon_hvx_context.c |  5 +++
>  target/hexagon/hex_common.py     | 29 +++++++++++++++++
>  3 files changed, 68 insertions(+), 21 deletions(-)
>
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index 02c54506145..55b8a40fe8c 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -448,6 +448,25 @@ def helper_arg_type(self):
>          return "void *"
>      def helper_arg_name(self):
>          return f"{self.reg_tcg()}_void"
> +    def gen_clear_ext(self, f):
> +        f.write(code_fmt(f"""\
> +                tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
> +                    {self.hvx_off()} + offsetof(MMVector, ext),
> +                    MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
> +                    V_EXTENDED_BYTEVAL);
> +            """))
> +    def gen_clear_ext_pair(self, f):
> +        f.write(code_fmt(f"""\
> +                tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
> +                    {self.hvx_off()} + offsetof(MMVector, ext),
> +                    MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
> +                    V_EXTENDED_BYTEVAL);
> +                tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
> +                    {self.hvx_off()} + sizeof(MMVector)
> +                        + offsetof(MMVector, ext),
> +                    MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
> +                    V_EXTENDED_BYTEVAL);
> +            """))
>

gen_clear_ext() and gen_clear_ext_pair() currently update the
destination vector=E2=80=99s
extension field even when the instruction predicate is false. The following=
 test
demonstrates the issue:

static void test_ext_bits_preserved_on_false_predicate(void)
{
    asm volatile(
        "r0 =3D #0x11111111\n"
        "v3 =3D vsplat(r0)\n"
        "v0.x =3D vsetqfext(v3, r0)\n"
        "r2 =3D #1\n"
        "v1 =3D vsplat(r2)\n"
        "r1 =3D #0\n"
        "p0 =3D cmp.eq(r1, r2)\n"
        "{\n"
        "    if (p0) v0 =3D v1\n"
        "}\n"
        "v2 =3D vgetqfext(v0.x, r0)\n"
        "vmemu(%[out]) =3D v2\n"
        :
        : [out] "r"(output)
        : "r0", "r1", "r2", "v0", "v1", "v2", "v3", "p0", "memory");

    for (int i =3D 0; i < MAX_VEC_SIZE_BYTES / 4; i++) {
        expect[0].uw[i] =3D 0x11111111;
    }

    check_output_w(__LINE__, 1);
}

The extension reset needs to be predicated as well. For example:

def gen_clear_ext(self, f, tag):
    predicate =3D None
    guard =3D ""
    if is_predicated(tag):
        for regtype, regid in compute_tag_regs(tag, False):
            if regtype =3D=3D "P":
                predicate =3D get_register(tag, regtype, regid).reg_tcg()
                break
        assert predicate is not None
        cond =3D "TCG_COND_NE" if "fLSBOLDNOT" in semdict[tag] else "TCG_CO=
ND_EQ"
        guard =3D f"""
            TCGv {self.reg_tcg()}_ext_pred =3D tcg_temp_new();
            TCGLabel *{self.reg_tcg()}_ext_skip =3D gen_new_label();
            tcg_gen_andi_tl({self.reg_tcg()}_ext_pred, {predicate}, 1);
            tcg_gen_brcondi_tl({cond}, {self.reg_tcg()}_ext_pred, 0,
                                {self.reg_tcg()}_ext_skip);
        """
        end_guard =3D f"""
            gen_set_label({self.reg_tcg()}_ext_skip);
        """
    else:
        end_guard =3D ""
    f.write(code_fmt(f"""\
            {guard}
            tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
                {self.hvx_off()} + offsetof(MMVector, ext),
                MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
                V_EXTENDED_BYTEVAL);
            {end_guard}
        """))

def gen_clear_ext_pair(self, f, tag):
    predicate =3D None
    guard =3D ""
    if is_predicated(tag):
        for regtype, regid in compute_tag_regs(tag, False):
            if regtype =3D=3D "P":
                predicate =3D get_register(tag, regtype, regid).reg_tcg()
                break
        assert predicate is not None
        cond =3D "TCG_COND_NE" if "fLSBOLDNOT" in semdict[tag] else "TCG_CO=
ND_EQ"
        guard =3D f"""
            TCGv {self.reg_tcg()}_ext_pred =3D tcg_temp_new();
            TCGLabel *{self.reg_tcg()}_ext_skip =3D gen_new_label();
            tcg_gen_andi_tl({self.reg_tcg()}_ext_pred, {predicate}, 1);
            tcg_gen_brcondi_tl({cond}, {self.reg_tcg()}_ext_pred, 0,
                                {self.reg_tcg()}_ext_skip);
        """
        end_guard =3D f"""
            gen_set_label({self.reg_tcg()}_ext_skip);
        """
    else:
        end_guard =3D ""
    f.write(code_fmt(f"""\
            {guard}
            tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
                {self.hvx_off()} + offsetof(MMVector, ext),
                MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
                V_EXTENDED_BYTEVAL);
            tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
                {self.hvx_off()} + sizeof(MMVector)
                    + offsetof(MMVector, ext),
                MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
                V_EXTENDED_BYTEVAL);
            {end_guard}
        """))

