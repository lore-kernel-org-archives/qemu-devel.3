Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35515606A32C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h2+Nq18m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZvPRSONs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPLzK-0006hk-JM; Fri, 06 Nov 2026 10:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xPLzH-0006hJ-OH
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:36:19 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xPLzF-0007hS-UG
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:36:19 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6ExwsJ1039344
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 15:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e/9Q6bOhiEORhKN8WEfNVRmZ/SJNBksgqy1FUFZpckc=; b=h2+Nq18mSHxCGf98
 TYUQJ28DW5z3+I8J232EC16hLZTQa9ixgX5SkFz22Gf6CN9wmF+UsIy0BGYNl4VA
 chZG9Be18PQxLgiFvXZvOyuuGLqRPFsFDPDTr9wmQ9qHczUH1yWgt2ASciu/s2fF
 Kq8L6YEUs58Txsp1eBobxH9fBw/ZSlC6ykW5EdMyPPIhxIiC2zTQkQPq3vY3XS3P
 FJYoiNs15hdEyrRfs10pvgoQp+jHLOxMHsYHuZ8JcneJfbVDv2+wTlbVJRmMDUBL
 HEJ6/hqHyXViWdqs7X1ie/Y/2ooVx99oyI6rXSFVDl4E5LI3+B8R0ULuflr8CWI4
 sRnklA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9uew3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 15:36:13 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4ab260600easo2562788b6e.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 07:36:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793979373; cv=none;
 d=google.com; s=arc-20260327;
 b=dPnUvl2OGCXTHJO+vNGyzyseH4iTnEjvXaREEMlkndfzLXRL31fxdvVsvXevDlFXLp
 DvhIOQ3/MroE6aG6zUMSWc4PgriWVEQoXHz9JpP8DN9jAEK+/kODlK58xH8iRPipX+im
 x9UJMgkgj16/pIFtOoW3GjjO4IV3YsX2wbOHqBp+6hsdQEi8GeqwKTh/WKrqMHrGjwZK
 PYf2/BpnlKG4hmB09Y3jDm9hf+c0qCGi2dbWAv7ZgEfp5ByklH6ltECCEKkaB0aKzRGo
 W/h7bJ04MfCaATvk+2W/soqfRvhfNUSWZC8H1hQ7BRlHilzjdTOAg9gW1bu/MOEBZC/+
 DPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e/9Q6bOhiEORhKN8WEfNVRmZ/SJNBksgqy1FUFZpckc=;
 fh=7/GdYppiTsB0NXa6pDpzFXflm5pjJHAnKN9qAtaUz8M=;
 b=gz203Y0Fvu3lOhmnG6jBklOeOIMxtvztzzT8YsKlnnImHaYWjwjZflxhIehtilHwIc
 eZpTU47PKvzUmkD6RmujqYTZ0i6NZbL298Ili4ly9hb70Dm6k6VpB0L4xR5mNqHTMg0N
 rOqBMJLJT4uNr/1jFawVjD/FoICguGuuVRfAJf+SsttxEtGhTlXYqkgahZtnSlPGUY0O
 rnffydCI91BgUf+qtClZ0ArsYDJiJ/QIEeaYkJ42NDUHWsuDDjTEi++O5NVfez9oDaUk
 OJU2ImRgZ+M6iIRnQaS53EATyxw5Md88E5d8OroMWUpMGur3kinqKJrMx7otsX65i+z+
 RQ1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793979373; x=1794584173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e/9Q6bOhiEORhKN8WEfNVRmZ/SJNBksgqy1FUFZpckc=;
 b=ZvPRSONsFhYJltEpj8T/nkANG5WPjyhFJHV7q0L72Ue7k3hRYnx0lPBF8zLWS45KDb
 KwhXH4efJhwIZm0sJldIjLvbq6aSyBHqlip4Haqmudp4ZBgALvzeij6s95P9hPWNCDiC
 F+sw6C9YflQT1RIZSYpZnEOdsswpCq9IRL6bKCChd/MIgNAXM1wWh6psLWYCIeHauqHT
 mpkQW014/5i5stwEZGbsYQL1cL9fKfZMWlK1LeZzyvdyzbfTlxRP/F4zzxz/fveTGjqX
 c0i/DgxLRkCiIKCwcB57xPw/Qoo6SmFMkckDpjcvtTVvmEwGAgOE9fppH1ilqt/7y7OL
 6x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793979373; x=1794584173;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e/9Q6bOhiEORhKN8WEfNVRmZ/SJNBksgqy1FUFZpckc=;
 b=z/WMDzjfTICl72ogNiRw7AIquVCbgvX2NfUsPjHc7gup297dO9IHTfpb+igAHo1PvH
 ZhlZBheLIvmmwyIlPlgkfq8KHr4QRvq8nB2gDasLJl5B6QoiZ1sD9w6K9N/9sp8Vq2wM
 FuXzHZz7LQ/0CbxMyRQipGdlt5FbniXzFtlLrok89k220ZvuhKJxBxpw4ZltiBiwHwBT
 OohGqm2PXBKvs/xjp6irABdNf0p/rkLRqvc1b0mJddb4U/tLUw4ylYQ0ctcU+Mej1grP
 d9K4jcnW+aQKp//TlQ6nWwePGUk5HeDSH5LDjIv4Dr3URwxw0i2cb04o+wzl/VOnHJno
 4R8g==
X-Gm-Message-State: APuU4Z8vUJsHkBhGq8W0ztxdQdwD4lmyENcUJUejYVNoaQvTlN+KQ1fx
 2QEq2dWsaxQ4jnG4yhzRnYeMK2RsqMgNCvzqdNYTNdye4kHts3IzO80RnEcTCllFL/BT/V0Saqu
 gPDCos6O6Y+cA9WUQMNecNVze/y1wagPtGiL2557UEwAHkf3gr+PlQNnUoRBP0S7vA+0UwQJxyl
 V5m9ly6CD9U/6ynaX7fdIGoYvo71wXkofe
X-Gm-Gg: AYBFou0G7tQH3fM+Rx0DBfoRkYiquHZNa4CsWBsa3RwE/TQkIe/HCY4GfhjTHmSyrxY
 tyCfU/XC4kl94iPWD1RfOzYnOwXVpQio6M4u+e8A8npeLD2kUurQK74M2F/xh2BYNNJxzRl83xE
 jJPSGx/B0ZDmB6LKYNoH6HzCHXdPCQGkZA2HmmRAXVOEGlNSygr1CURx6o8edxXUyZE74IDb8uy
 K6FR5Q+tps7pqWXQg==
X-Received: by 2002:a05:6808:6411:b0:55b:f88d:6e84 with SMTP id
 5614622812f47-567be6d06fcmr3433687b6e.37.1793979369921; 
 Fri, 06 Nov 2026 07:36:09 -0800 (PST)
X-Received: by 2002:a05:6808:6411:b0:55b:f88d:6e84 with SMTP id
 5614622812f47-567be6d06fcmr3433677b6e.37.1793979369419; Fri, 06 Nov 2026
 07:36:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105075346.52926-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261105075346.52926-1-pierrick.bouvier@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 09:35:57 -0600
X-Gm-Features: AclHuK83KfFN6z7vO99HdsVQNG_XewxbNJGIq3cXH_lnoc51195lJ39yvOvPwqE
Message-ID: <CAJ+KCYNBsro2NFM33aJ--SYHHsmFB=adMJ1tosq3ehQutgTPQg@mail.gmail.com>
Subject: Re: [PATCH v2] gdbstub: reset supported features on Supported request
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 brian.cain@oss.qualcomm.com, Justin Sapp <jsapp@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX7RmsyIb/9IMm
 Gisb0GyGQ/SYN9qRt3EXdfUmiSTpifuq9j7VwLGdSOa7GqRl7OZH8OpLiWAmuEJla5AygwTP65H
 kfROr7U8Z5V3hnA1bNtFA8Mb15XOWA0=
X-Proofpoint-GUID: IX7jvoGGxCyHMsJwYCCKWQPbRmNlJqH2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX5hZBVI+xuDpS
 36qro4+k/aPexADIJ2Gg9wWgLyW4SzBlc517rM+M27pckeeqyAh/C1Y9c0GCuM721XllsJj2XsZ
 1GgMkocqn9pqUSjk+LGRzBOT+/2gAH0eYMka8QDrjBDwPLtfF8QT55/7v+5W8aFTxglDkm4a7qv
 De6FeKIYZHsdq3Tz3m4Esf/+x65poCYWyOBh0udxKzgsbKlR0K73ntU7B/Rgfp0UvD2iNmMYcQA
 tyC0xt96pb3gjRrvH4NGHkL5DVTRSQ8oTifRWKdZzr+6AysL2ine5FKlQmbw0yozdfpDIGozF3u
 5Rug08sXwY/Iw0JOF1uvA7Dex6Uha3fU7TkpplEQUj7bNcKIUtLErKl3j3evgX9biGqrCpiXWI0
 sY1Qq8Kqr85OpbGW5vHvkBZ1HmI7bvaiNx0uYuUQ3GW577GPEd1BB6Xdu3cHDxv+eL1f1YtAs+W
 xO/6lg4BvZAJKGrnYtw==
X-Proofpoint-ORIG-GUID: IX7jvoGGxCyHMsJwYCCKWQPbRmNlJqH2
X-Authority-Analysis: v=2.4 cv=ZIZCCn7b c=1 sm=1 tr=0 ts=6aedf3ed cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=CCpqsmhAAAAA:8 a=EUspDBNiAAAA:8
 a=lDtavSEJtHVKaDUYZlkA:9 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 1:54=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> From: Justin Sapp <jsapp@qti.qualcomm.com>
>
> https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Pack=
ets.html#qSupported
> ```
> Whenever the stub receives a =E2=80=98qSupported=E2=80=99 request, the su=
pplied set
> of GDB features should override any previous request. This allows GDB to
> put the stub in a known state, even if the stub had previously been
> communicating with a different version of GDB.
> ```
>
> We exposed this by connecting to gdbstub using a gdb client first, and
> then WinDbg (EXDI) for windows kernel debugging. Since they both
> differ in their multiprocess support, this was confusing EXDI.
>
> While we are here, fix the same for fork_events in user mode.
> Simplify control flow to always call gdb_handle_query_supported_user.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  gdbstub/gdbstub.c | 15 +++++++--------
>  gdbstub/user.c    |  4 +---
>  2 files changed, 8 insertions(+), 11 deletions(-)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

