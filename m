Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4B8C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzMUL-0004tZ-Nh; Wed, 26 Aug 2026 18:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzMUJ-0004tL-Tn
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:52:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzMUI-0000TC-Fv
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:52:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdlFF2021106
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wNYFDyxT7WAWVOuSfr/Yb53H3+k6XyloluexQYY0JZs=; b=aI8UyuQ4uuzVQ+oW
 lzsLurL+28AAxrQid8G/223fQzqprXKmXijBKwZogmnZOdebH2s3MsvyZ7gGMw1o
 ApB6qgAH9sprugNQj8T20ujWxWJ/Uitv4g1XeVkey/KVkg/DzwFsPM87Qn03W3um
 wwU7xhhH4OWOUuqnZgJ+0aIou3HgRKumzkpa4DhOR0aZ+bgnwiRfsY0SwlOuzN+h
 NA9z5zIMsfz8WVvKENq4RvoWTZIVTirULa1OCADS+44ZoGgk65HrPB2k/g/pLPgB
 YOzBgMLcbsMyA8NYCGh+sZkAc1R0iJgrjSLcbnHq8JttyChFgZDgUDakKMAJmwxc
 l570Iw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga075a9bg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:52:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbee6bb8408so1744760a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787784771; x=1788389571; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wNYFDyxT7WAWVOuSfr/Yb53H3+k6XyloluexQYY0JZs=;
 b=BRLXvJ8fDFStxXv5JkuRGew+rsvIQua1QGDI5OoPnx10VfcEQb5d78z1TIQgjDRyWr
 9iwYGMtTrse6xIONJtdh40UPpXY7ZYBv8hZG1gIs+Fzou6gNOSrHmb3e5jA5NnTQbtVT
 QpT/FchYIr1MRWe4wtUt6e9AZu77tzeeobhJMujLggr/5O9uCqGXeNB4LKmvd+GMl/F+
 bKs77IMM8pbTM2i4ZLaTbHXpB5L7iypXr3Qy6gKPxOjdvh4wg+C7CxQoja29EzwxyMKG
 JXqcLreaXtz27nJxbDiWUi7WLCzm5+a+FP4VrzGdgv9pCr8ud1AQFKq5EzZDaxLJ1GDG
 OzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787784771; x=1788389571;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wNYFDyxT7WAWVOuSfr/Yb53H3+k6XyloluexQYY0JZs=;
 b=L1qjPuwyiJPvBxOTazwfWjUBuV0298DjWJdt6JyWYauQbCZukb5Dc5Bai2hd/4LEuw
 FXEWiz0hzi1C7PpAd525zh0PBQ5lZ/enZ+ecBv73vuKErlxJgR8SqIlj0WbFJReh9QRe
 f6nZInG48HkG2mCKEq26yF5Mm5VivsWSWHXiJp8H5QO7A5LOtaqArNzCGP9yF4LLhOKz
 RlTrn3vV+/pmUjnsD5J7byZZRwFqdE2W5FdUPHTHtcve0r3BqUumz8y/wJzwRxfKsM4M
 19sOq60bFejt6Z3qPZ/kJrT9cyXJ06oBMxTD77YxkzpFMSveAaE8aNS4GKFKVFsNoQoz
 woGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCtj9enkg0L49YTSYUxrLLIP3iFRz2P+4qYBFR335NfAhRpBLBgB8etUzJ/OhKth0jZf2PCAAcyEgv@nongnu.org
X-Gm-Message-State: AFuF++kzBjz7s7HgKECsCiFkjxS4aLYNzxva3uAP45UTdQ9KBOF1p0Ap
 I3niUo64tbeVE8yIp5bACfxCmBYsiVpOwzojItI01xMFv6JwjVBfbb8W1bVM9OtzY34/em9t0Wg
 4jzScPI17HVKsmqLgkEypmUuEBkoqRU1s+YEXajpv74z1wAtBfZwd8IZZPQ==
X-Gm-Gg: AR+sD10sR5TcLiGaI2NpGjCVuuFS0L9VgOPBUrpZU1t60vgtxB7ttzDmMwuZJirjYeT
 Y3oksF0egyNShZTrDbqX6FHPv2ae/yT0wWpSuABC4wT7BItFH6zk+WYCeS71hrScj0aFTRC2J/b
 VUnjbWf0AdlvIUuAQ1dUARKbz4Lumq69Qb22ibpsQLAJyr/3RnwMb5Hq+GsNS//Gh9ywmIGj/xT
 +bYTVtKzaE3T4GYkRwxW9Ii+kJ7z313O7aQCWAWgPSm242ZayksP0IdXwUW6dkg8QT0I4e66wtx
 NJeH/Tt0jWsXzWrR+L7b2JiJ+jtsGtii8NhAyLQmOaQPeUR+DTt0fKmd4vC5QHBf3QzJf/ykKwf
 jdFRw7AGFB5fjz5vCyqXkEUZtHEVGwXqdb03CUHyM4yTzR5ZYnMpY6Yp5VGmqqh1NiEGA
X-Received: by 2002:a17:90a:d2cb:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-3966d36df78mr21568366a91.2.1787784771537; 
 Wed, 26 Aug 2026 15:52:51 -0700 (PDT)
X-Received: by 2002:a17:90a:d2cb:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-3966d36df78mr21568312a91.2.1787784771147; 
 Wed, 26 Aug 2026 15:52:51 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d884d5esm11798761eec.17.2026.08.26.15.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 15:52:50 -0700 (PDT)
Message-ID: <80c9b445-f367-4542-b0af-15b4ce518a2f@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:52:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] disas/hexagon: honour target byte order when
 printing instructions
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
 <16f730778fcbb7c287416aa246367c1d0244b267.1787586642.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <16f730778fcbb7c287416aa246367c1d0244b267.1787586642.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2C3jI8tBM13okPUW3RV2EHSWbQ-tY_c7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE5MyBTYWx0ZWRfX9Jgy753UE8Ib
 N5g+xbB5ab6F1N9ZsyshiR9A/Tia2GErttmvhKQC819koo6aF5HRo/NM9N8yLOfSQaC7zqTUGix
 NRX9LHrQ/PjMJlYwi1fwyKyXG2+JdF71WcO2QP1bw7o9RRO6TnACS2stysYNnoC6FvoVa5ZWLPC
 GNJT55VASIxuNYqZ9ibJXlYaLOk9THeTv7WfGaG9sq/CpcI2fuAnCE/RUJpfcBE0XkRxEotlW82
 WMLaYz3/lXAYttgc5upvcK0XRMVSrUlMzmeEVK2kREqNdfKE9poJxtYHpsunmqiO/L2BNs6B3bm
 GbDMe/nzV7RGo1iq7x2egG+rGILS9T3txXGJy8HVlfUV/N4GimBCgSFJEZ7c8QO4MH0t5dsixsp
 BkzNeUvvmXDfBwAFivkcHwWZ5Jg8iA7yM/qMD/E3+SLSLp0MtYmSg7NIQhJupYAiVqeqD3KulFv
 czQlcIenYSYnc7JWGKA==
X-Proofpoint-GUID: 2C3jI8tBM13okPUW3RV2EHSWbQ-tY_c7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE5MyBTYWx0ZWRfX7psvmOkXXhuH
 GrLvMTx5Vkg03WFM83QBOXAhBLk+SoNnF2g/y2gXS40Rj+bV3+Mm5Wkue3Ao9okfYCzwYgSRT1Z
 irP6s7+OlH/Tecr9WYTQJPQoa19O/NU=
X-Authority-Analysis: v=2.4 cv=RPiD2Yi+ c=1 sm=1 tr=0 ts=6a8f6e44 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=D-Kn8PrfAn60CojCKvQA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260193
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

On 8/24/2026 8:58 AM, Matheus Tavares Bernardino wrote:
> print_insn_hexagon() read each instruction word as a host-order integer,
> thus getting them inverted on a big-endian host. Instead, read into a
> byte buffer and convert with ldl_le_p().
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>  disas/hexagon.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

