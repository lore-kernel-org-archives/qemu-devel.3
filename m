Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0C9CD98E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 04:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZi3w-0008Qk-M4; Wed, 17 Jun 2026 00:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wZi3v-0008QF-8z
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 00:39:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wZi3t-00089V-Gh
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 00:39:39 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLTiw6769082
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 04:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wkpsG/0y6i3lRPZE4jC2IfrYaNtTlt1JiDucvG4pXkE=; b=CDH7JDVnQ+7Sko1n
 WZp6EByW4XY+QqHbwAvC0BBBSm27ozV30Mlo8O3XBG7CyTOieuuPrF8y7u9MjtHM
 FGiu/exakeuQPNnKNuyeZLVJS60pjaJca9luVZJk6D/8+XBNF8ZS7I+7y8ChwicF
 9Xp3Vx0LSQ4bGr44dqNnadwo93VWUOvNeIzweaa6bPyIRKQldUDEQQ+M0r4YShsF
 /F4lgX03lj9dvQzoMiNRfa47UssaCIyfVdSoEAv5pOp5u0sYd8ZvRbbOhi1QsOI/
 TkH/CGhO7HU/iItc9m0ev7drPwZwa3alhfxHM64H178Nw01AVUl+xjsTllEFl5yB
 a/uSQg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueer9cr2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 04:39:33 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-13980b6561dso6088733c88.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 21:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781671173; cv=none;
 d=google.com; s=arc-20240605;
 b=Ep+NVTK1MjVhy//f45Penihzf+SMOXEm2Tj0FN9ndf3YbpqI2xVnGvYnOBdTQyHBpD
 zYFy3iF3ZLrW4RL/8cyALX7DTeUfFA+egpCr9pCu9cr9cPUe8ZakY40A7GIYC4OwV+pK
 2hCet3Ap9CgSstTS1ZwlWcCsdpAILA6ry3mPDXJjwRekzNutVztTb6F9L6L9C3WrSQjW
 iZTzrikMWWPrWlTep+7bxYT5vBn31iifsCQCpmK5F25DWzNkMKAHWswQqQ82wfhR+NYJ
 uL4kJfWTpgpSUSGe8dxK+tDDGlAczP4aykij9LeA+0wW0pVnqMA3iBUKlUC8holYwna9
 ANPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wkpsG/0y6i3lRPZE4jC2IfrYaNtTlt1JiDucvG4pXkE=;
 fh=JScYN9ggEtJtY5/98v0r8Qgb9Q06lch0gd2Ye3hFYCM=;
 b=JutVcePrAPo2pfPqR8SpWBqpobvsN6O1ubdn1gMspKcUNzBYmaQ245GGvU0XzFhtQR
 mheqygiArljMVdLoxJK3SQZWQEok/lwtzikljcdH85P2x2wSlQxjOy6XXmm1aPuiTaqC
 r828BYPWkAg1Sr2ZQD7ub7yGgmXEQ3Gaz3RfFTsEvOwEW3PKoEz7qWa4n1GIILQcONHA
 BriJ9YD1m2QfLfeROkPRxB5Ww9/69OkFgPawi8Ha0jbR5GIuIUwOzu5bf/apW9tGsvGL
 Lqt9U7j0vNRnOYXC0KSoCxvMQnIQeoIrWTzccxkq0lWIlY7TdTmlA/8TnngVTfzdl/d7
 KsGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781671173; x=1782275973; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wkpsG/0y6i3lRPZE4jC2IfrYaNtTlt1JiDucvG4pXkE=;
 b=OuT22K62y4tutOgMpIkkJqhnIZ7laBOXg7Cgxg+ipyi01wSPc+nwfL7i9qm0goIH02
 sNVkDl9zKc5RkH3HZRSjr4Db0wKDuVQ7D2S0kol+n7o98dvi6HaNvOkaeBwYaPyvJTi4
 kxG51CxfbQFpxYHqdN1KjlmeGvx0zswy9z9R2KBrp6wW+JpK3eatr+x8bCFkJnTkA47/
 O9TX5HkXY3aVzut10bpu4ZKJ29q27IlZuA9BPeZToEy3v8xTvRZnyNCihwMdukgPRKu9
 T4Z8YXoI34mjSj36sbLwSmIc99+7Qusjg68a6DAC9K+owQAKPcZpKSno6Dd/eDCrSm3n
 c2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781671173; x=1782275973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wkpsG/0y6i3lRPZE4jC2IfrYaNtTlt1JiDucvG4pXkE=;
 b=X3Nnmas7yzbO4jITRVNfy2I5X1bCcs6vDKlp6r7E0f5o7AcMXitKwcE0DmuybnPU/3
 wGq7vNVm1hCpO+OglusdGCfwRa7CA1Hzs4qc0mhkXViwSOvoaS1jshbbcCdFyo5EKX3d
 C4lMk9VjkRgrLArOaYwYrCVFSfX88bYtdaBQVmQx0UDRNp4ldMyLkfsgKVCVQZPL3pAx
 T4QP0ovwfpaqqCCUlYlM95tqACo2V7vPKSkddvu6DeAcsV9iGo3HS/9gukBOKnZXYzpR
 g7JEdFnEHFErBzzZ0iaILIiZ8UJ4UCINmdoHQrA/dMGwGLZOyR/hJwTa7IwZcUhbpSUG
 PL4Q==
X-Gm-Message-State: AOJu0YyNHOjKM4afhUomlkmJ2l41u3oV8ZjIGR+F5ua/oQ7Zbg9sVS9e
 ky8u54dGqolNaNs1ksBs8sd5yV54YQ/sRILGJgztIYS/BFdL0CMN2zh3Pdi2nSxuS3SoxLyOfdA
 0pGv2kWIadmuP8zvQZE+jIOl47p66IQ1vIfKSunpoO4F2WUsonM+L/eO5gpmweQXaoqIluuL/2Y
 xM+A9uqKlZxjl1pHM23ooX3z7kEeyjJl4B
X-Gm-Gg: Acq92OETts+0OydzUsga4m/+jGM+KRq7gvN0StMHtUFDPJjI05UDUfdDp401C70kzNF
 HzosJEBjyfgFPrjiVcC0Bubs9JRP0TpLUH4GXEspQ/WUQPZO0OpStmQ6cMHuqeenafOon0Selyy
 AGTB6jYj0YE1ZztEx1MI1S6qx8HztLXycHLzG96Z4TCMp8UP+Nn5XODvluAusSN5/4+x48
X-Received: by 2002:a05:7022:e995:b0:138:22f:9a42 with SMTP id
 a92af1059eb24-1398f67b55bmr829332c88.9.1781671172938; 
 Tue, 16 Jun 2026 21:39:32 -0700 (PDT)
X-Received: by 2002:a05:7022:e995:b0:138:22f:9a42 with SMTP id
 a92af1059eb24-1398f67b55bmr829313c88.9.1781671172443; Tue, 16 Jun 2026
 21:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
 <5c42a81c-e7a0-47e8-acc9-2be70c8a3380@oss.qualcomm.com>
In-Reply-To: <5c42a81c-e7a0-47e8-acc9-2be70c8a3380@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 23:39:15 -0500
X-Gm-Features: AVVi8CdNzaHfiM-oX9Vvid80WDnKUkE7adYBtHx0BNguZaO-8fNd7uqqH_hIm6s
Message-ID: <CAEqNhNYSKj4oxYSf6Q9y7LkcvNKD7-5ELxOcVypfEPR81mdbHA@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Hexagon system emulation - Part 2/3
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA0MCBTYWx0ZWRfXxxzg2m1Qabl1
 nZwb/FprtvAzqqebD8d1ZDblaG7L7u7BzKwHVIzXwGpIyYC2AB3vk0VslQww/3BRYq8qNCdmSx+
 5tqvrAKxQaso7lkeZUTa1GLY780Td68=
X-Proofpoint-GUID: TPrOcznghaYi1UqZqMMB0LeYJd6DRQDe
X-Authority-Analysis: v=2.4 cv=d4fFDxjE c=1 sm=1 tr=0 ts=6a322505 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=n7VB-dVX8cKyPGOXhlcA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA0MCBTYWx0ZWRfX7PkammSW4UqP
 2wsOw6SJPD3EVasTHShEnGErfn4wJq783Gnxm14wPl1gYVMngevLVfy/mtcO6bsyozkD/3K7cW/
 A8/yfcJjjkR5jXetMndrXY6rf9PFjXGDXXK+sUZ1ur5+VPVchX1QARSK8caMIfyXGYc4yYTYJpe
 ErXwKqUBA3okQLcJ87w0jFYnSbXu+Nc35IqeIP3edHzrdrApO4baxtZzLh2MZyebwlKA8D387ie
 UtnEnEcR1bA0vqeNpvnnJvTQzrL08mhykwhncRx3hJaiGhu6gQg7RPkHGBz1aK6Pnci19m7NIxE
 a1HnLiw3WacaGqDYytm6S2t4gmF6HtZXZTsLjcY1AqbYCwj3556lc/qAwpdqglqQp15YtL4wTbT
 cSPUPZMZIyk5isURl+NgJVI79jnIXVL9ExQsZQaV9HFHyvO5U3oXGQfRfVGa2QaC8ytntBGl/1B
 m+p0Qla/aN6mOz/oOlg==
X-Proofpoint-ORIG-GUID: TPrOcznghaYi1UqZqMMB0LeYJd6DRQDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170040
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Thu, Jun 11, 2026 at 7:27=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 11/6/26 07:32, Brian Cain wrote:
> > This is Part 2 of the hexagon system emulation (sysemu) patch series,
> > building on the infrastructure from Part 1 to implement the runtime
> > helpers and CPU operations needed for full-system emulation.
>
> For some reason this series is missing ordering, but is fully
> reviewed AFAICT, so good to go?

Yeah - sorry about that - I'll fix the ordering next time.

Yes, fully reviewed: just wanted to share the entire series w/rework in con=
text.

Only part 1 has unreviewed patches.

