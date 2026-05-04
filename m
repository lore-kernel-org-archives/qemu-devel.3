Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4C8CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 16:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJwc2-0006nO-L9; Mon, 04 May 2026 12:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJwby-0006nA-KD
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:57:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJwbx-0006IV-7b
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:57:38 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644DlpSh299673
 for <qemu-devel@nongnu.org>; Mon, 4 May 2026 16:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sKnCB3uMdsufH6spOo972yKBPaRdQuhJAPNXjlGWSGM=; b=Lj7joBKsdTrfWL/A
 mamym3e+HJ+ZjQ4DhMoSiRnDfqIoV2UtQrtdFfXHH4kJ4EFYuVPpue5Vz6SbVgR/
 aGGEbYiPDf412uAH7PSw5OZ0FFeoX82RawwfUOPV9nDgrg0U0jNo86iloc9yJv+x
 uM/A7GK0jmt8jQgdE+5N8egtpSq4h+13Hr6ALpYJhCBnBqm98qKGEhLDn+TvIz5D
 LbVd3FaQ2InkzVB3u+pwrvp+J6Y3efHzVIpB5MCBR5fuhB/oUs2svQSUYH181jiP
 ZjzgqRHmqwxyU5L9V4xC2Os9RDHwO3G/k25LNrY36WgrXBgtUhK2YWEyvBrPLds6
 DC8NOg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvnd8rgk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 16:57:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2de07c12745so1739347eec.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777913855; x=1778518655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sKnCB3uMdsufH6spOo972yKBPaRdQuhJAPNXjlGWSGM=;
 b=RwKZumq/fyBIHsBUiuGcyGZ86cIw87xSPnrGDrpDUjm3TwQq45CjOmM6OJYFLJkJiJ
 JqNFRlhtwZATFsMK2VpnB/fmVW11yaoBRUh9fgAL5xuBaUrvB0Njh8uLAemBSJb8AXF9
 OW5lw6JXrFGIzABrW+NOBPu6lpxf6oxtykxnaG1f+kx/tjIT/jfveIDWrrVOxfehep1L
 uWXLhc9yIEh856N8CfWagqRcRD9G2s0nxiG0sNyvfJIfa8BgLADEeVp8NBisa/0xNzJQ
 /JMR3mJvHRy9zTKi8wBILRideaNZSR9Rzf7OlRNbhZq72Qbq/mDyxKH0ccCgrCn6bfPB
 mkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777913855; x=1778518655;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sKnCB3uMdsufH6spOo972yKBPaRdQuhJAPNXjlGWSGM=;
 b=TxpnfojvzKtX9gfpMgWxFzy+3/GiJOqRQbHgVBZUpjTobuMsIPPVqLBuKYblwy+fys
 ROwInjt2O5COY0at6jN19ycYr/W8bR1rApPuBVtmKHoWKWz/fw9Z1stkjFA0u/RUt1MJ
 /yM5PIStebX+vvC1ksKVWMhVW0810TNearOE4jwvNy4cCkR/cQ0gGeiZPxgvDV5mLEKu
 o1SI26Vp/3+s4wdtuAbAQKIGG3GA1iKHw4MXfBQ+SA7JIpUop1yGi7Xar3XFRFJzqkKC
 mqZFiNJQU2HNK4V762xRaYneXzc9nQTgGDqSeTIdo3FBG3EPT6bIu8Y+ByyNZZFV9bCq
 OfZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WkFa/d9u1cLlH0qy0DV5O3WN53gW/A9kxm2GRr7IiwJ9K4KD52l9OfqQX7Y4O28oU308b7O8CUOtt@nongnu.org
X-Gm-Message-State: AOJu0Yy+GxdQ0ngp4f4F8lKBwjQ+uZKg4fCJWvh871pCVlpVXq1QjdV3
 xGM0VYjw0QfCc4rm4IsHK+fNN41OviwzT2jtJQLqJS7pB57TAjRQwDfIf/wrg0QdbSDzlRaoAwi
 JdV/LWjDrm13omf67mokoUCKpMPv5tVmJI8zFC9swDoxuw0dCVqdJ14nt6A==
X-Gm-Gg: AeBDieu3Q8lVbzPqFcT3ko0lSGUZfRYH6qTnGy/5q2NrnRmHw+n/rXundey/LLBj8tP
 ePc92k6UFlcvo/KUh4O1II4HWT8rWMfUF5Gcx11CtPnYUsowQiETV9J9ju5S4IQxvxv6JWAHW+T
 K7hSEqPMyIujMc1wDn+nRdAZWtYHCz9Oe8Muf/rL/6D79dJvhF0dkokL3FKPJS4fjqiUFRYbANz
 T5TGFsGVXlBTPL24he6+wGQKlyCNbb/raRiepxzDaDgb6ALdmDusfycEBu4+QKLxvA+sYguWG9Z
 1AVmBn/o1aLJsPuwqCHmTJ5rfLtoMSWJNVhUIz8t+CeV5EqnNA3pccUM4jpXkVHlI09N0jwJT8d
 PrSnZdCBmfHoZEz46bRqtd2cVRK/zhjK9tw4eOZS/rCAtRit2zl71SbVli0yniblXawNwwB6LGP
 facVZNRHu2YtrL4xbzbs9BdxFz
X-Received: by 2002:a05:7300:fd0a:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-2efb7dc9c89mr5256260eec.3.1777913855247; 
 Mon, 04 May 2026 09:57:35 -0700 (PDT)
X-Received: by 2002:a05:7300:fd0a:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-2efb7dc9c89mr5256241eec.3.1777913854637; 
 Mon, 04 May 2026 09:57:34 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f28f7ba26dsm4942204eec.10.2026.05.04.09.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 09:57:33 -0700 (PDT)
Message-ID: <4f2490c1-fd18-471f-a886-be21440aa552@oss.qualcomm.com>
Date: Mon, 4 May 2026 09:57:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] docs/devel/tcg-ops: List more vector opcodes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260504125032.35465-1-philmd@linaro.org>
 <20260504125032.35465-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260504125032.35465-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lK8iceqQjn3n4W4iVSjW9DSdasfUiJta
X-Authority-Analysis: v=2.4 cv=d9jFDxjE c=1 sm=1 tr=0 ts=69f8cfff cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ArTqPgEF_9_7nwiEB5EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: lK8iceqQjn3n4W4iVSjW9DSdasfUiJta
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1MSBTYWx0ZWRfX/2+bLzGtLhI2
 5AlOvLZ1m0Th323dLMCgumjk7fsZa6m8hRec1Z8jlbXqEYusIFOYz+cvX/pP9tBYPApJrR1a68z
 N+a2T6e5qYHgSGt0rQrmgjjLEjq//nP6nrSgTjbg06T+M2ly8R79sMAwD3UmWP3OkHjftdQxQnB
 rLeWI0PzxOczoTZe1v72nHOn2osOlZ6my+qRyXmsmpLj44c5MJ4Epkowt85tBpOfbAjQzG2CVAJ
 EFE+/qKOxX/5haDO7PWU+Tho6OzeWvBhfw0E1zRFZ3TLbj6xq4UW/KijHCmx5fZSKKy0ld37O13
 HhDF3Q9kyf80ewITuCxRRgaSJ3GT6xQJPK/SPq08z5WzyGB8rc+idWSBCly+mM/LhRGk93mEkMz
 1LYeBqif44TVGLWfrap9xGT25lu9SfYT/muKf8gUw5IPAIfmTug8W2Iks2tMQ6DwpFiQ4aIpPOY
 z1wYlSRuxpOCD/8W7aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040151
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/4/2026 5:50 AM, Philippe Mathieu-Daudé wrote:
> Few logical and arithmetic vector opcodes are missing, list them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/devel/tcg-ops.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

