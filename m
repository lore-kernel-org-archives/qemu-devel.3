Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEED606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MRkAN3n+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XuzGjOXh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJE7t-0005wM-Lr; Tue, 20 Oct 2026 13:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJE7r-0005sr-RL
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 13:59:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJE7q-0004KR-CH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 13:59:51 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGu4jf1926031
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x3ikiFG6SpZFfecUYMBnEw17KBkWyuibWLmfHbyGL/k=; b=MRkAN3n+LsczkHMg
 2KB3Rnfz559wzbAEJpznN17hviwbOw9JiZwicl0s1OVBYDmhacg0wV77MqtK6upp
 flyBbWyIltnnxY50hA14eav7RZl/C2FTv6V6O4S+by24v9qsLVl90KlBci3K2zqE
 wvF03w/7ioWLYs5TpCs+qISw3uB1Bg2B3XZy/SnM9y0BzNqZY3pqWHqDTzy1E5Qu
 ccivECqZlEgOUIOzYGVzrJotN3dzG4r0a7AvyS7a6yd8NSfgFoO2nwWPezE9OCTH
 mIjHTequCptWON2cMloEcXhhSrrWUn62cElVa0gdmCqd87LbTvmIJXvt3VKE9Ibx
 x1ItEg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qbt9e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:59:48 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-54dbbf252cdso1607970b6e.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 10:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792519188; cv=none;
 d=google.com; s=arc-20260327;
 b=QPV0u5sqTg/m3zEqpVYd4/ajSHSLYN8DHVU+A9TfUYZ8XWzuq4s6Vw+Gdn6EbCcpj4
 Otg24O182BGiIha5rBP8AD2KfULNBuL/eiRFMF0bWxjfdx2J0oPs9KCoG6clQvA0epwE
 ex12wl4iroK7PbTpRk8NfjXKrVn+KT8IntohXWOegKv2B41Jq4WOZ5dD/JXESe6wEhTX
 lFGaLEiCnXW+L4toCP+AWRzoeegZ15OgHHkIVK0wVqVG11/ZhwieEPKrlAaSa5NAWoNB
 L2S3wzMw7XGh2J31FQWLwNTKfxSdSh0sI7//ueQAQptAR9dI3SW8WW4zPD7H+sv9kX0C
 Ondw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x3ikiFG6SpZFfecUYMBnEw17KBkWyuibWLmfHbyGL/k=;
 fh=DkbXE4ccMsTX7HmhBC7cW9zKYDAyLxQ+nKGU9uhWHTg=;
 b=C0Q93+UiaHl6iZLaqBIUql6nqrYK9h30pFxLYpBaX83bE/GPqUE/xxX6A8dgiEZeiA
 72krhCUHG3jQE42wix7jCci1Rfly9Z6mLqTokkpeJ3u0pCqwXhMUlAYQVqW5i3q7MMkV
 7uWB47O0ZYkcyqHGWXKQH/le+KqjI6VneTggLPYm/1b7zsZrLwezwPWYVN0zDa/CLXyZ
 6b+WEsLOYaAmlOwJULXSWMYRaH5BiUOaC36Q2F8yf/Evgx3MDcxMEKAlUpqDFhXJHQk5
 VgOyPkSfFyPLB4noEIhJQOwTDBNK5kaX9bL8DXu+Dv+Ljj1Kda/c+B3srUBcgfVNVYTM
 bQQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792519188; x=1793123988; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x3ikiFG6SpZFfecUYMBnEw17KBkWyuibWLmfHbyGL/k=;
 b=XuzGjOXh8LRJAYUWG78BxObKwlsYvfEKKfQxLsPpGXYhrNRXcIF4jYgXPiZfokg3xK
 gUlj43gbNTJjXVump6e9ro0CS2nk1U1+wLPC0B8h93FKc9ElYtlSQWfPq/5nU3Lo+y+H
 +w/ZDChijRPN2UigJjd8/Our1BWgMQkxRhQgksqN17gHeKADdlgXY+UPJuPguiRr8JFz
 Pm+/75RBzreTfDNpdlISt+gcy//4DXAc1gyVba/m7+/nxxxX67kvhwfTJ5Tn5YeqlWDv
 0R6x5pFjgnV5s6CA3xCanM/Uq+sS+FlQkISVPKEfWt7DLmfxk+5OUI/Ra0cYezwfVpT9
 gKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792519188; x=1793123988;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x3ikiFG6SpZFfecUYMBnEw17KBkWyuibWLmfHbyGL/k=;
 b=Wz+Bv76+z3aCZ3mtMtm7ikmzOWXunQMuLSqLartqj6AnumpEb/kwjSC9/f9nQPNcf2
 4Pm5aIl+NHHyR2q5+wew2654tU+Kt/T//Y9AqByv7VujEItPBsj7dJ0PPAPVmeg5jdnC
 tDMA/8XNxiJdXczUJi96ZyuS+tqbHfSJGXAlPRPLht8QYgD5YXf3MsgEOzuxwUrgYuS2
 +QqW5aZeD64L4y5nu7o9TtwdK1Ngx9iP8QlG2pIAlHUyJJDQmgfJQAk5S4J6AHoHbfAO
 agdHB8NDedqIs65Et/0UF2Zo89sv2YwARhQe5tnI3Gh5iAEolts1F46RImm4L2Jo8Zek
 3J4w==
X-Gm-Message-State: AFq9FYLMS8ZghhC2Un/NAFDydg5g8Vz6kB5+NnLRyjXUj2hmz/cDKuxc
 A8Ib88KpQlQIiwZkSF6Lje+pPz308ww+qaOUNyUjA69DG/pkEPOxk0oxJtCg4/yPKI8+1SRRau5
 hii0d7yMiWlwB8iFcHIly5Isa8WfrCtCwWMnRZw+Er61Hhm8tOssgH0IfXujzwRLHxoZ8yxAfWL
 Q0grKq30wouNtDSEue+UDrhZABPj4PnnTA
X-Gm-Gg: AYBFou2fqA1RR0vhAmBl1uBWzGnSygnqQ55sONihYT1kVBMAf7eRsXJB3Wy/yLpmy4J
 Nny8lcENkt5ZaXTwR3aTIPzsnWrDvZ1Kg4aROADBQDKDMpU7lC29JU38SX2tPqzaFQ/vBdM77fJ
 UUlmbxnC7EPHLnhVdYIVYloQjkmOVRsVJBGz6UrnyjmOhy8qG+eFy1gMO0T2ZFlMwFWGCWCPs1j
 3XySZBKKpHSJFaQ2Q==
X-Received: by 2002:a05:6808:318b:b0:522:1ac7:a573 with SMTP id
 5614622812f47-53ccf2f4046mr10053823b6e.43.1792519188167; 
 Tue, 20 Oct 2026 10:59:48 -0700 (PDT)
X-Received: by 2002:a05:6808:318b:b0:522:1ac7:a573 with SMTP id
 5614622812f47-53ccf2f4046mr10053809b6e.43.1792519187714; Tue, 20 Oct 2026
 10:59:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
 <20261019172603.2625677-8-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261019172603.2625677-8-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:59:36 -0500
X-Gm-Features: AclHuK--WfhsoqiSGXZDjpxhILXR0RSiwoLBxieU0vmEF9ohHgF9uBNLmMyYCTA
Message-ID: <CAJ+KCYN2Tp5bbRhs_fbkNR6oCq_NPdR=wBavYtTM3xPDVNgL2g@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] target/hexagon: reject reserved L4_loadw_phys
 encoding from v83
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: tEvlkvGAI8NV6EXb5CsYjlVoNNrpcVAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3MSBTYWx0ZWRfXzFjAcJ0YfnZs
 yWPcfq+NYIdXrhcn7ywkC6kTbOISF+EqJFu+W5Vi1q1MSRKQmXPaXZrmJQc5w5cBHyI+0BiP0cE
 40qeZeDZiOFwBuhYUcw9rg1upa0YlaQ5HPqhf0my/w61MRrpuSTak6qL3/VnU2WuocjwDKTMsD9
 lo5FszmHk5A8NBZ30GxtiY6JvgHkLN4SV3b1M+snkbAEaEMIauQxJC2eGdfrHGJbhUduTBS48Wh
 K7A3f5LdX7/BdVQ+i7V94jQ6Xyn+Pauuy2HEa+lGDOzaBKJa3r1Mr+Xv896DjluzF7jgO0KtBw/
 2LNUXcZZVQc5JqcQpvKTH0gecX/AdcvJk3WBOe4rYgVtq+e/gFh6puwDuOBvcYVnx63TDdjIZhE
 aahW+aqj++OXnLnTxsZ6k/PK8i2my2XAUqJ/jWdV374xytPOZwp0gOKDNyPSGDybKQ05AarK1eE
 6oQbPyWf7uKN6GrMG5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3MSBTYWx0ZWRfX+LZ148W5uCsM
 OhtTRDd3z3Rz7444xE4qrrUleYvPIE2qxYUkV6CLZzaeagxoRnNGdikOd4+y6mDJpxbnwRx1Hs7
 lNNtoxnaApRG/TjnmTcq4wm5KthQ5cQ=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad7ac14 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=1s6MZQv9Md2iBDlLmnsA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: tEvlkvGAI8NV6EXb5CsYjlVoNNrpcVAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200071
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

On Mon, Oct 19, 2026 at 12:26=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> Bit 7 of L4_loadw_phys is valid through v81 but reserved starting
> with v83. Decode it as a legacy don't-care bit, then reject it for v83
> and later.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/decode.h    |  2 ++
>  target/hexagon/decode.c    | 19 +++++++++++++++++++
>  target/hexagon/printinsn.c |  3 ++-
>  3 files changed, 23 insertions(+), 1 deletion(-)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

