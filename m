Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F21C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 19:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x41Kq-0007Tv-UP; Tue, 08 Sep 2026 15:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x41Ko-0007TL-Bm
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:18:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x41Kl-0001S3-29
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:18:21 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688FdXuO2899194
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 19:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QpGOcfBDv83YAWjqyqJyJxySjgsKtzf+x5XAK6VohGs=; b=MC3NSWRZ/CEXWcru
 25Bb8LAVUewci9FcuLLxT4ElUVsfEL17dwwBQqpgOVhgF2wchm6IMJBTCkOC9c/C
 5EHT91eh+tYyRxoCp4l0jOQSiKYF/lHhiYI6e9wLcG9L3sZ29LpiWmiB+odM86A3
 N35rNmGb2iDS7oKdJv0MFNwKVyIF7IpXTXViKyvhUTY3T+pk2szEiK3C+C8M1CX8
 UL4QU38NagH84uX4GEZiB/O6L9Oq2Vmb50j15dtZWLas/WkH/w1pnX8VJpjyN4cc
 rVb5Su6xR7tj13CbKAbKd8FjqyD4NsAfznrb80ntpn3y8rztyVqyOErYG6w+ERpi
 icIIVw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcvukfvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 19:18:15 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7f66ceea676so7114157a34.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 12:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788895094; cv=none;
 d=google.com; s=arc-20260327;
 b=pB+oXGoxD1+cfzwgNeKAqZSR7XS9IuMUyIugFuwFGjTRnVl98ORFK9dIkdq4JgKtlP
 ceqz7rsbMmMITELqy8jJjHvyvIrzpTBtxcAtgLoY+q/s489yqBJ5W41fnvZS3J9tFvJE
 LkG+x5I7z6iZNoVzRCMabJVstWbgFaOwDpij71meKQq1qathQ+RbNDe4P2re8TsUOULG
 025zORzdmvN5UVww1JAWzdue9liMZFWnzmNmVt06IH2zEQ9rjzN490WVYBli28+ecJlJ
 H/PPpn7GtsXrjh4BFU0NMmSuahdRRriXUOwpLcw60WkDY97xAKyAHV8PyVjtdGNAJaFq
 lRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QpGOcfBDv83YAWjqyqJyJxySjgsKtzf+x5XAK6VohGs=;
 fh=srcqNiGug+bO41ZHFZ5y47Ye1x0tXQ9yWrRvoyyw00Y=;
 b=mEFb4wjq4kuyHZQWN2oapgICbYR1lJ5krnDn3JZZ8k2RwMQXHemSBC9buiDf0PL9Sh
 FRNZrcxlGvV+0ZtQaLAsiPw3FYTtsW6FMhE3tl220GxlIIsQ0CPBJ7JZzJ1pAcugscf8
 miGtCWoGHmJAnkl5R2ra+5z9WMbq9vY2b5vaXrOC5D7ZSoake1TMaQutSlhODfAzsDza
 BYtF2enknzpTiFTxg6Mx2UitVjUIahZ0aniFF9F/eY0snwkQx7VOc2RZpFzi92DoR7Rj
 tu/gXIZaXqLTOhsUsBe6rC9qGiLzkkBw1yCsramTW74QSdalkvZudW0t7wzIMfDq7qvl
 W4cw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788895094; x=1789499894; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QpGOcfBDv83YAWjqyqJyJxySjgsKtzf+x5XAK6VohGs=;
 b=aBmYTowXR76wLR/uTR0GAvHheRzmRV+ulmWN5AvU+bDnfjRnQS7xz0/mZm3s0e7Y6p
 GeW7yjNnE1UwXQgB6R3PmAis0kC6OIa87w2QztdAEt45Mx5ODuTN5lymmTiaec+XPbNn
 TKDlbUNO4FQ22shv6ux50MTN5KaD1B8Nvv5bYx3d372lEM3iHO2KH8g7ZXzW715jq7Nw
 CVNT/tUNP8AiNwVZnEJoWZ4umXMSzjatFYcqgA6A6yDDXp2UoURdn3JTYhFl3+DwOam3
 ddsstpbDvMkQhcs/x2dOrs06HK4xWXQ/p1eVAZH82kDI/Vl5WHM4FTNUPis21sH47tAs
 3n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788895094; x=1789499894;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QpGOcfBDv83YAWjqyqJyJxySjgsKtzf+x5XAK6VohGs=;
 b=Yy7fOnoBSKB27rdLhvalQAe5NlHBtpjb02A/OlmpTp5vNHihRgcvtdiDPIG/DtAkT7
 bBgFtQNQRSZvUpbO30uBBbjbmUhkAHEsVraGqN1uj71Suz3qRWua6Uvjhf1m2Vfw70Yr
 f6mhwO+SRWlooWx51BVcz4wkQIlg4poLGscSpWoDnEL+5TOfIa+5qq3oqbWN1O0J6pji
 ZCZmvZCCgS8MngKjup3r0u2qxOtZTBFeTbtGONaiFty5EPG24+oA2WIL1HdTSkESa4+U
 /ZXgNinWz/Bo38cHbjX6zRB0NQCShkcBQauufJDMVkc9P+PhtWcnsgsNkIdB9Aq+5HJs
 LPYg==
X-Gm-Message-State: AFuF++m2QniufBtii2SPzpycRtJsedqu4/0JGSfsS1yx4a6tUE4Zocj9
 ZLV+ZkksgkFtNO1Uv0cO3OPd1zghMTH6gkdQ5EJc0kl3TkpJ8NhGP622TrrXgi4uv7v+Kd6P2as
 sx5hnNxfh9iXJBDBVn9jue7/Ci2UFgWugR07+m4AIdS9vFjG/EHB57Tx368bhs/jslPu6e3naAh
 +3x3BIg2qOhjCVfGCC8cUpchai5TiQZ9Gr
X-Gm-Gg: AYBFou150PKYo+pJmtNpGHyPanNumWTD/+MPLoUmaGgFeCI3qju8Lq+DaWF1Q+InmV3
 QpXOC8FmPQF83cJif3AiHJTAb9w3tJpIYS784bJ8kJBlNOfN7WVxr402+5oATwj0MHw4fkqX+do
 uCK1rzNB7VctdW+Qig9UarlhXTYJel/hOeWcsrtrhBxSJM9Wwr7KJzzi62og==
X-Received: by 2002:a05:6820:2084:b0:6bd:ec40:e809 with SMTP id
 006d021491bc7-6bdec503d64mr457231eaf.13.1788895094156; 
 Tue, 08 Sep 2026 12:18:14 -0700 (PDT)
X-Received: by 2002:a05:6820:2084:b0:6bd:ec40:e809 with SMTP id
 006d021491bc7-6bdec503d64mr457212eaf.13.1788895093676; Tue, 08 Sep 2026
 12:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260908190628.2767509-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260908190628.2767509-1-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 14:18:02 -0500
X-Gm-Features: AcwNN1X3izLTHlrfWcn7Ju4zjwIHyo4q5IBYTeltGVRcd5ESX4cTwSxV8QINcZs
Message-ID: <CAJ+KCYPOheKv6Dpf-h-7bzrh60vbxu2eWpLP-dxkNd9p=_NAfQ@mail.gmail.com>
Subject: Re: [PATCH] docs: Correct semihost spec URL
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ePkjSnp1 c=1 sm=1 tr=0 ts=6aa05f77 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=1stHdRAlHgUgcQS99UkA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: ffGTSE0N9Hp3Q1dY7DnrLo30TCPeAfFO
X-Proofpoint-ORIG-GUID: ffGTSE0N9Hp3Q1dY7DnrLo30TCPeAfFO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIxMCBTYWx0ZWRfX4pqJ1HrIxCJq
 KmvsLdNiejM/chRH8F5fL26ZiaaiE9D0X1lvTTv+SciaIBGx/vebqke2oTApIxat8ypX1N08TRi
 PLioYoR3+r77M74X+v9+Ro7C1tE54hBiUfwslRhBULrwk4zWRT7bAalavu0p5oUmBJdLYtlCzLS
 1y2jo48JdgGyuA09GkyEcj3RJJfyxO2oywM+GFH/TZAq8UA3IHCHjXaNePi2U3K7TaGnjBCRCXn
 cT+sQiob2DqTyRJ9LfG+A8Q5hZz9EWakQKk6LaUz64htOACbGmzJss+JI6VgFH3alWK+McOP7ph
 rkYpsrP7JFZHVUeQU3bMkF1ofssJk4XmnaNrVg330uCmMEKlmBIMAwxFGnJIvDoUVfa2YpWxXwo
 BfM//aaebXZ7EyK0AMO4ss4eMzbjuycwYVbmY2y3cEmZlXfej3yINiqu+sheuQdebIC3Wpdmqmm
 M5VfDqSx53mefC6QWMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIxMCBTYWx0ZWRfX4IRXmU9IwpqN
 M875Y1YpeFzmFuz2o0ImM+vX8MSqEIw+HXeNWURTyqr1f+KtdjY48el+fkh473ny8AO/nJNkukF
 Gm1fdsmI/MRiaaVlOM7vZ46wh/5pKpY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080210
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 8, 2026 at 2:06=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> The previous URL worked at the time of submission but it appears that it
> was not a portable, durable reference.
>
> This one should work better.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/system/target-hexagon.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

