Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67D3D1951A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 22:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUkh-0004ti-W5; Mon, 26 Jan 2026 17:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1vkUkg-0004sq-2v
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:08:06 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1vkUkd-0001FL-GO
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:08:05 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60QKgKux3707352
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=d6QeOwzk/npXMYKI6GaJVJbt
 VMXEKWrIZzGVeO7MR3s=; b=RiwjaaoeWDJXD6P2ABr9JIC7hDqgeeU7Pn/IMQh+
 00a1TXQJO64W7vPW4sZOSDv1HJjJKutbxpevu4+ZMJgeW7GjtK6sgHDHleg9BsSf
 D51oeXTMTZaRLuPZLV2NlDhi5UVd2rHBKlbiwohJSkAXdHLfnbhH9BNAAvoiffUO
 Bw7F4tRyXuyehcgrSBPvL7sTaeiJV8eWD04PuSALjmyJEyx53PjVhF90ZkhiJLqO
 wUUbr8q4D/8DatlvfIEZz1HqhnPiiP4yQBWmFnUrzP74JUBS+zaMq57sgYvE8qAa
 amTpQ0DzGezfFj/uaIFQhlc9jFB3DLB3o9Fpwh37r/J8MQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3bg8hy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:07:58 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7942a34f311so70712457b3.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 14:07:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769465277; cv=none;
 d=google.com; s=arc-20240605;
 b=lpZ4b387kK3BGL2+YWToV0UZgtqf/81lsF9RyCdT17YP+QElXYmrhjbHXSC3cZNBnq
 uh8UdC/musysE4dAYDskicRNJIm/TrADkIiE3rb7AsOgfp+Y6bqUFgOUZFjgqwoCDM9c
 83ZCJ65FYQ33Y8IXX9lGOnQ1L7wLB2lzxGYf/iZpBloJDi7rmGQyfH88AZ+HinUEQtJr
 rs6L+A7ZSwol9+B1WZTNucYT/hK8BX5i1lwr0WkPHcoVNCiEq9uuXPii25Hl5f7VLpcy
 YugmODoXLztPqd8/2IzyPzVjOy7YmMbNvXqHmr2wS0vmmCVO0iZ/TeX2HDPxcsqy5wZ9
 xe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d6QeOwzk/npXMYKI6GaJVJbtVMXEKWrIZzGVeO7MR3s=;
 fh=LhEaV6KTfLTsr/HY9s0+UVINUW2LoeQ+C1uDVpTrfbA=;
 b=BDNRzTWnLyyeGsGC4pR4fs0sCYllkL3W3LFApM9+5pcrK2Jh0cvRSRt6Vnqyr1g86i
 gGbwNdyvP5V5vexvz2P5Cyq6OlDs1XQ2yd6n0FwnlPKvFnM1bH3vTw98LeaF2bUYp5fs
 FstdCA+lDlq3w8WN/2XmnHkIkr63UMwNDuUERdXWefjWxgjStw/0UjUpXDtOlCNzxMKg
 8mhnmuFk7PsnuRY7fuWsPSL+B2/2VvSoalo5FfuaN9fU68+fsfcGn46y97OPsAp18FOB
 /t81OeWkBO9J5+Pp0p8YE1qBKjIbpCcsQi3ViGO8YoHpa821sB5+bu0Tfx3MBCboCUdN
 N/DQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769465277; x=1770070077; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d6QeOwzk/npXMYKI6GaJVJbtVMXEKWrIZzGVeO7MR3s=;
 b=hUDFLBVqXO/LNQw1RyGVWvVVbkM7BIztWLWuhLviyDlQ7TJwkIxXtl2FZHjYsBFQB8
 TjdZJ6VqBR+u3MX9uUpzqfzFtXmI+qaHxwXdGSJ9fQP/uGI2UU5d0TqPqyN74I/2i1JJ
 fj6VQJ4Ugc8Eue0y683wurYF7t+q0yH4Q9s7lC8Cyagjq0tpjFFsxqs1vxQ1xVYoSRly
 Bc7xDf6wF1bd3TgL19+wyWHWJR7G/YxRVUTcMvAs/1DS0elpKKTuxfUWPyOe6mTITzxw
 TNh9kUstvjRF9JNKvXpoWMvPDK86GgPeSjtnpfmMR0zERbgNtG8Q9NdDjpNVlEPVj8TP
 LFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769465277; x=1770070077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6QeOwzk/npXMYKI6GaJVJbtVMXEKWrIZzGVeO7MR3s=;
 b=N3pnhC5S5lnfelxczHKhZx35rRwCd5oxcIqFSiW9gMi8PNt8j+2zZa8OAKhawzTlc3
 nEyo8X5m4lHG3hSqUGVolua2MQpoeajMc6KfHZX671jqBCw1Tsj+Yih+0uqiQB4YniAa
 BaPHU0U37TL1KXhPXDhzLUvtZVdxTSFm1q3rtWIxaWCAXKXIZth9P+CBLdfmYBunaHWC
 KXtGTF+HIDZGI6u8k8imzaadNEdeYI+IEJZH1eaU1L3G3MkNvVJsSmUx63/GbwNw55rG
 o7xq39CQQhJBsHuhXUKtSR6SRL3C0zq8SHnj4jticMbquvRRDH0nN2rk2X0TaGoZ4Bjd
 X+Sw==
X-Gm-Message-State: AOJu0Yw/zpSyg9AEjR3MN61/g7haBGtSzlRKEcF3KcHVKUbZ8RezVssv
 4emorxokzFQ5NSNz1ZBH7AT7esEzrrTzGBRwLRWurn9Snd77aNcK/r5qO558XjbcGM8E1NuEzFe
 S2wLEaEksgGKklGfakMvOMVkjM9zXtHyyhejG7PnHHOl5rLuZoSiEd1YPg87KzkB+W3zk3Ml+OR
 3IN+3kW+rX9oK+Fk5jNG0xrGnHQ7zuTv3D
X-Gm-Gg: AZuq6aJ6OJLptxI+oBKQfWx05VyH+9lkH3X05RiaR9tcjPbwkgpbFRvEDzvOiXMGJUy
 a/sY4ya8ylj5Vz1WmxMzZKjFXVxYPz0UYb8JE6CzuO78NA0YrRZGvgOihCyDA6AoqJTbrKraOnO
 bJiiE7J40Ay5cvDeaDct0nXzaN2cqAzsBLZnb6YSOOWY20G/L92fivxUD6p/Q+i/c=
X-Received: by 2002:a05:690c:6e0b:b0:794:2ef:a441 with SMTP id
 00721157ae682-7945a9a34d6mr43607217b3.48.1769465277603; 
 Mon, 26 Jan 2026 14:07:57 -0800 (PST)
X-Received: by 2002:a05:690c:6e0b:b0:794:2ef:a441 with SMTP id
 00721157ae682-7945a9a34d6mr43607017b3.48.1769465277118; Mon, 26 Jan 2026
 14:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20260122223423.1076448-1-marco.liebel@oss.qualcomm.com>
 <CAATN3NoZiPj5wfVm6+4MGEnrVX4sdZhnS4Wj7-_0SUe5u0wZ5w@mail.gmail.com>
In-Reply-To: <CAATN3NoZiPj5wfVm6+4MGEnrVX4sdZhnS4Wj7-_0SUe5u0wZ5w@mail.gmail.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 16:07:46 -0600
X-Gm-Features: AZwV_QhYxsqDVk_qomDXQETsL_DpxpniBFsg4gMDEemk-86ftZ_qwCotSWRj9U4
Message-ID: <CAJ+KCYO7YK7RSMz=LwT3H8vHK5Y5KJWa9oWb=ZweQ10DA4jpGQ@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: Change DisasContext packet type
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000490c84064951bdee"
X-Proofpoint-ORIG-GUID: aha700-45IUhJi_McSDLkbEaBpF1ESFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE4OSBTYWx0ZWRfX3585rJLvixJN
 nXbeODnNOmFDatQmBz0yJ+yFwvfdX32RANzOoK+v1qkkt70nVqJHDcyDrONWcxJ5iHsyKRdSjau
 h8G+gU3hs7raI7KfWWJaLunhvDR/SEbZi+aCDjHdpZzIZwPDHv6z3kTuhZFEDX8j2B2GlTSGnK3
 f9WT7J9mlxgtd9A8j60OqCc57fxadtiIOEsVMrMwgJQAO4iuPsEbKujQ+ABBQMMIdXgA8I4/M++
 n2NJ2KHKCKjmIRTlY1rDxZ5T/2AFHOVL+K7PQI3ai774Bpsk8lWrHHig5Vn3Fg1VniOCoYfOW4j
 UMgmKoMXj49wYxMTmW9dxfJ1KIv3picAO9noKDFY2vQ62c4u5X8OcLIopJ673pO2/6yMce3/wqa
 nCFrDLFm/Kygrffd09ZwUWQ466yaQq8vIUSpWYm4+xw3xzO0VwqgLr3MtFIvsgZI/qswZV7oxqN
 128WEu7FDbhkPLWln8g==
X-Proofpoint-GUID: aha700-45IUhJi_McSDLkbEaBpF1ESFK
X-Authority-Analysis: v=2.4 cv=AOFXvqQI c=1 sm=1 tr=0 ts=6977e5be cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=qmvyfVqhrmzsos48SFUA:9
 a=QEXdDO2ut3YA:10 a=fTtp7thc-jC6ggjaTskA:9 a=E79ym4VV8a-vR6-Y:21
 a=lqcHg5cX4UMA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260189
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

--000000000000490c84064951bdee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 5:41=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com>
wrote:

> This patch would be alot smaller if you kept pkt as-is and added a new
> member
> Packet packet;
>

That would reduce the patch size, but it wouldn=E2=80=99t remove the risk o=
f a
dangling pointer
and would introduce an alias instead. Is there a specific reason we need to
keep the
pointer around?

Thanks,
Marco

--000000000000490c84064951bdee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 24, 2026 at 5:41=E2=80=
=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com" target=
=3D"_blank">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">This =
patch would be alot smaller if you kept pkt as-is and added a new member</d=
iv><div class=3D"gmail_quote"><div>Packet packet;</div></div></div>
</blockquote></div><br></div><div>That would reduce the patch size, but it =
wouldn=E2=80=99t remove the risk of a dangling pointer<br>and would introdu=
ce an alias instead. Is there a specific reason we need to keep the<br>poin=
ter around?<br><br></div><div>Thanks,<br></div><div>Marco</div><div><br></d=
iv></div>
</div>

--000000000000490c84064951bdee--

