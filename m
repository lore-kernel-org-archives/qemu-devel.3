Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6792C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Xkt-0002wn-FT; Tue, 15 Sep 2026 14:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Xkk-0002u8-0v
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 14:19:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Xkh-0000Oz-QZ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 14:19:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FHoZhs229785
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 18:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hh01Ji9HGbkH+rz6Ni66HTL89mHlWAakKV9B3OvuaVU=; b=PIVDvqkMdtSBPdPQ
 F4IyTQWfeFbuavW44B/56fflwCea8bPvDgQQI2PXkEoVk+ZuOrx/uyxyzYF5w4E7
 HLuVGyvdCWLn1nB/ZozNXYJbCp1mlqRiRX85PppQQkJz/P9VJ2u8Z842Mkd5t+6p
 yoi6TJMzbDKoIfXnX87tnziRi/qQs4P8O++hs2k0qR79QaqjxGAr/5gyonyuq1r7
 tAo9BUrc+2C0iveucsz3FI91WYsUQSguDULc9pf11GQoz49iTedupD3U6paJeOQx
 gyRIH8zNUWfEMhWS54QW21ZJfoy542xPnUn/IDXm1obZO2ohFsfnrFg5rVEBRWsy
 JmYT3w==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqah9r7tr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 18:19:25 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4b28db6c77aso6421657b6e.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 11:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789496365; cv=none;
 d=google.com; s=arc-20260327;
 b=EI9NwQAifU/gYy7sCSawt+msdakl6PWwh3PeLwYQ8thCfe0kcgw49ZAEWerv4KnuVJ
 mcbtlbG4nYVWwowK0g0zXtxftoPkyNsmgI5AiAmjt5C1UYR6eEo6XE7zrFvNOmtpgq4x
 /WiYbCBjl2katJooDRnkPz0U+reZTgzHJ/emj3cCRdrYmkJ/oq9D96dQmRmxj8woG99o
 qPYxRho3UAwoMIIMHYJASyTRIiLx4vOJ2pgCj1DZkII979afMd0nHLeMi1oXlykKiNC6
 vmgu37T0Wft2i28Fk+rh5XZgCXK4TZ6dhm5jl9995i+RWjuAE8KlDQDJls3PiZDaiA2N
 Y7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hh01Ji9HGbkH+rz6Ni66HTL89mHlWAakKV9B3OvuaVU=;
 fh=OSkAXfMXEjEHEK9eR4/7X1OkKzMaRPS7D6WMhg2fqKg=;
 b=e6dom+yym095I/D6ijifA9ouSXsE1XLPYUfa9QO0PebX9VuC2KzZjoHNZELzxwxdBf
 njUq2UPyylnbmFs3E4Cmq6n58QhIJQZCEmKQWJCsCR9RL1GGtGomGnwk6XAW8TBsyjaL
 zryRlAKNZmZihwkUbAki5kQibjC/HrhUb1vY1bvyZhXR2lO9vwaJnOTmt5v6pDitui8X
 XzbpXsSUedmCjLktCYiAQ6jrYknDnDHiaqJcchUyNunz1N3PBWsKzgXdOLucIRmXDqjW
 XF95fOw6YnOMg0BD1g+MLk4/GVDZ1wKC5xOBAeoYpTSWp3PqXkwOzMGJfR3W6nqhVPlg
 SLxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789496365; x=1790101165; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hh01Ji9HGbkH+rz6Ni66HTL89mHlWAakKV9B3OvuaVU=;
 b=EMfeSZ9lk8BlDcdDsqWxYAy+WJC4uPEIQb9SiZfRp3Qldo/fNao0ZEQc2i+QNPzB6e
 RZS7lYrwce+x16UGW5ve3yjuiVrCJg7ABLn3k2g3X1rBxvMain8/6R8NwBztPg+p7zKn
 u72qDDVqbPhSeEn/kXqIOkS1kI0nHB/NjUP8k0/qJILLTZ/0Sig0GnfnSDCyeXdGfJxw
 MYx2MP0DiDAiZz5xWiy0KA8NoORpASGlcTmKIvoMvKd57PYKMeLOyxBNNJN7fMcKk0Im
 /iPrGsTMj21BKpgv4fJZYgvcZtqrey6qKiIgMW3L8AdQpg8/c0vrnFPpbkUmibZDxyU2
 MTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789496365; x=1790101165;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hh01Ji9HGbkH+rz6Ni66HTL89mHlWAakKV9B3OvuaVU=;
 b=vcT2KGOQdPtpOmmalStTfe4VMJhROTde4DUMFkYRNLoqrD3OBGFSy9gAXw6LEwE5S5
 gbH+OBQxI0UwUeAu7orkAmZZrxrx4Js+0ANjkFyuEQCpTJpeZ4YvZWedX1rSUCprrEbe
 MhD9mXvMz6Y7Z0XM5lA5Ym6uxkEGfPsy2wCYysJ5WOIU9f2OQcw1c4ZMP/VUjVyqR02f
 VkNmXc5hiEDlRIIo0PS2I+LDhdSK+BmHjpvxMx704jtSGd4xhK73xZWLI++p6kO82zI0
 T10xVwyFx8EfT2ebwJEZUT/XcW5nR12LVzkYQGBrQopCNeKwImXpadDfuLG9rks16nHT
 CkVg==
X-Gm-Message-State: AFuF++mCken5G8TbJIsUJ4PZx6wazBraMX9UQPvtq7hR1UZgIbhzPjJl
 Lv9xLRCgch+tMCUh+g6OzMcRmlI1fYM9C/5DSLM9ubSdC6naBKRLr2RlfDxy4sDMO76SH+/fB8B
 2lfSy73A5CQGOkGiMAhs2h29yl0uG68UgDoIEfQh9nePz2312vCUWhb0cGuBSBcWafjQ22N6MBU
 TDac2AoIXscm/i4Oramrc3TAtG+FlrcsTA
X-Gm-Gg: AYBFou0yynf1cXjAYW1zyE+G04V4/U8zv+hi4TILPA1Igd39tmET0MrUrWG4O7rq4cd
 oJVGLYC5Q24Nip7Bag9mkjnQ1dwoiGCGSwDkImgwmFHeg2riU3wHg5l7lfdS5IaP3o5zv1pL+kb
 Iak76F0P4q3bhgPTb5xbUKxK4AEIgdyrpJdoWAPn8GMUMhhe06ejsNImC6rvuxtuL/wmLatsXd2
 R+PI3XTVwXnVOpixzY=
X-Received: by 2002:a4a:e914:0:b0:6c1:f38e:7053 with SMTP id
 006d021491bc7-6c736f6422bmr1741401eaf.3.1789496364872; 
 Tue, 15 Sep 2026 11:19:24 -0700 (PDT)
X-Received: by 2002:a4a:e914:0:b0:6c1:f38e:7053 with SMTP id
 006d021491bc7-6c736f6422bmr1741361eaf.3.1789496364369; Tue, 15 Sep 2026
 11:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
 <20260914215037.157879-10-ltaylorsimpson@gmail.com>
In-Reply-To: <20260914215037.157879-10-ltaylorsimpson@gmail.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 13:19:13 -0500
X-Gm-Features: AcwNN1XaJHI3PhbU6L9mgiWTB6vURILVf2i-rzyAZ5Y_ek07zT84-dj0cZn37s0
Message-ID: <CAJ+KCYPGnBHw=ENUgyhy3RAVAeE+iMPch=DTBtzybb9NwOHKfw@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] Hexagon (target/hexagon) Check for sreg
 multiwrite in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BtkIUoX5 c=1 sm=1 tr=0 ts=6aa98c2d cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=oiUj86p4EGMqR00RCskA:9 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: LGf5mB7D0hHt1WBG3rJS4RsYsfhEGy0-
X-Proofpoint-GUID: LGf5mB7D0hHt1WBG3rJS4RsYsfhEGy0-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI2NyBTYWx0ZWRfXzXWA8kPzH1lN
 6jjzuAfv+pLW9cpv26/FwwZMcTqqZRC9u23dxepbxx7Xz/wVav5nbUaZoRD3gfFxbRjaM93dBqA
 ODrMGLss9/1cnN0lRU5/geMcnySQ3K7wv/IKkVNROYnXJDnlbet4Ldt/72b0OdPE0u/N+5oSvi7
 /I89ZIXjXrlv2HMnz0vCQGgJdcJOh25hQjZseqy6R08Iy1/lmHFhv5Amq3Cr00UxMvcUBKzcmmP
 ttdaWmPQw5nEZ/VBkCV7E3ZU6txwUUnUVbhQR538QM48JxbQaDyZ+6HIAWjevnqulBE1kh217FI
 3WeAZyoePhN1QkNXQw1VgUFf6SxBSUOgfKuNK0uF6pd/mquIcCDlqGCmwB9ui+7ub84dFTuZ5b8
 aF/pjWscUiZnFpC6yYUb2VRP/vUtOhCia+zR2j6y2frmw64XztdZR8V7BV4lRfU9Bw4vpoNdgMQ
 CuR1St0I5iR+cZXQ5rA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI2NyBTYWx0ZWRfX5XlDYkcsTIoW
 AaQMuhzz+IoOTDPb4gzIc889uGpSxWeVw0QOCLCMNC+RXuPuxO6y2TSsSbRHFymjuZJjWI7kEUZ
 MK7JF8RNKAIvbvrOfcP+FkUiL+WPz+o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150267
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

On Mon, Sep 14, 2026 at 4:50=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/translate.h | 11 +++++++++--
>  target/hexagon/translate.c |  6 ++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

