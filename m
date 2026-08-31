Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A181CC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vfR-0004rS-Pm; Mon, 31 Aug 2026 02:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vfQ-0004qu-JT
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:38:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vfP-0003yH-6X
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:38:52 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52VOQ2423210
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qaGhzOIWEvQWDKHWqLhyn0Nd5EAJpJOwlyVEu6NOFzg=; b=RQmYc3zfhPmdmZZU
 WO/SpUhsSiO6xrRK2+PatxXacgE5MhIoWn0Y+pPQ173XEm+HRHt1kr7xvamnCbH8
 rXuab3AAJWaGhq7x+0bEVGD8bvDqBSHOqM0zZgcUqjZspGbncfjLtHBucI03j1a9
 IW18Y6WBN5xEW0CSft8guhhwRsDMqabWX/igx7DiBhn8pwcz1da8tJWDbgj6zt6w
 S73Nbqqh7iy8y7Uk5Jf3Uh/vUeazPut6013dlRZActjduDVEORkiojxmfrFXogIo
 3ZMGaOIHFl/a8W11OtTGJ97gTq9J94guGaWux8DY7sPgQ4YFsb0PZnuCTDwww27B
 GDaOEA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqe2d0f3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:38:49 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90e8472ee1eso16448726d6.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788158329; x=1788763129; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qaGhzOIWEvQWDKHWqLhyn0Nd5EAJpJOwlyVEu6NOFzg=;
 b=CHDAA4T13S+S5iYiw3Boz69CUjr+YSiCdAp3sPbwtIGD6rFCvOaQjF+ghtUxQjbykZ
 zEc2RArPf4ShHywNjIf7jyfyclFSA+e3SYHG2ksxv/OascJShDGK7OVBP16HcthSOlzX
 B4UGSzuGvMaRC4R/qGgehqXYNEoeQF4Ny3WGXdGZYH2g0EndxmEURl4RFk/nBjmReZPy
 quIxa+vUa2oXBJP36MVhWQB7qkM46MNU4VvEQE4VCn+ebERR+wjGMmm5WWc3BSIIrAun
 qyXaK/HeZ2HrymQhJay+x/imIJ8/hrzhEprvBU+5KHb/Bbpr9NqwRQqz0hOJeL3DCmjn
 0Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788158329; x=1788763129;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qaGhzOIWEvQWDKHWqLhyn0Nd5EAJpJOwlyVEu6NOFzg=;
 b=TMGO7G7ojXppGmEJmjzXSYCSFLlgt6HAswIK0pLR1bNp78tTKUAudOsmYmSOWmSKKd
 3ofsI/6y6w89NotBsrzPvpJEXhv+6O8zvU3u2GbsEXGGYd5V5o8ZzEA9d9ARB0v5hc/C
 qTcIuKrUCnuRhvJpEuAkcepHML/oYe7bj09v4SA/NX4DmN4AfHbV0wteH4+IxYR1wL/U
 4Y3CrB7SvDHahj0GNdbVgDC9am1gHVqDpW5f8HO4hkPwtd9GYhIUZQ4YVYexLhDxnnmv
 W7qH0eRSRGz2ros1IY9W7hFfBg6VBcXObpPfTELnvC7UAsCYxZPQYipAkwZEWoEPtyia
 oipg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSNcJEjK9SkdoVzc/+VUANfHPreinzYrWR/E3Btd7zUj0lf+/zMhYnIGJhCg+TGmgHfCR9BSyMLmNZ@nongnu.org
X-Gm-Message-State: AFuF++lbLAb6X6gXMgHFtVkuIENAgMlLvK/g7XLPSZRX74S7YA1M+3Y8
 e9tT3wlktuZM73P9dDHIUkLJeoEIX2miWS8LijmCwbVPd02C7BWfh5dJzub8yslCORieYiEc9oi
 ioFQO+FAlSbzUmA9xwzod8emMOTyj63mmSfv1BbllAI92X6PrrBTYsyq74T+YLyWJpQ==
X-Gm-Gg: AR+sD12Xxwk/cMq4nFa46AtEV3KpnDKPe70nvTg3pFzM1WZAtWHhWvUdkE8M8/SmOoV
 IfLz9064Smvw+GuiG5XZC/Hn2fDIgEbK4RlaaA8HUdhwz65hHanF6M6sn8zeQfQFeZulS3sBm0a
 5KjMEHqoFheGS2XCNhPnIdv5Qs94b6QAmLSdzIsV5OpV+r/ITKWxhvkMTCICOyUvYfs4JF5NRfY
 fY/g+r3P/scOzgDNzHm0ITn6ds+LNRrLGbdURMr+gLZEptPofK4Dg9W/kSkKxieqm4XtNdSGfLu
 V0ZVhrQPmHxGsLIiU4wd26W4EdmiDfO+W+FAXP5QzIlNEYtFmMMV2haMh5+APq1Q8rORnNCeI8a
 kO9LGNSEXOz/i3U0U/Iyl+A6mKOCo8q2K9Q==
X-Received: by 2002:a05:620a:454b:b0:939:7c8:78b1 with SMTP id
 af79cd13be357-93942b2334cmr82167085a.24.1788158329240; 
 Sun, 30 Aug 2026 23:38:49 -0700 (PDT)
X-Received: by 2002:a05:620a:454b:b0:939:7c8:78b1 with SMTP id
 af79cd13be357-93942b2334cmr82163985a.24.1788158328755; 
 Sun, 30 Aug 2026 23:38:48 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3fcesm19572755f8f.5.2026.08.30.23.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 23:38:48 -0700 (PDT)
Message-ID: <6348a568-cb4d-4de4-8c7e-256ea19b735b@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 08:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/47] hw/arm: filter minimal set of machines
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-11-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-11-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Iskutr/g c=1 sm=1 tr=0 ts=6a952179 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: WF6FbRxdpDWgM1692YfOEPp8Fw9SCkc9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1NSBTYWx0ZWRfX8bEA2GzQKgiX
 E9c0nxjHgqF5cPpJ9CtVGqit4ucsfQ9btuf/NvlxeiN89EdNfgQBuP6jI0kHOQax+9Ck8LqUzmO
 yn8LzHqbpv5tm2Il8mtKeoAfqZLOMqk2Nuskm3ZzH57VXfj9vWjh0Q6TPXaedYol6RakpcjvpuC
 HnK+5jfqflx1oY/wN5e4OH+MZ9NuumrtKhkfK4wpP6CSLha17BVtWzyggcmsEqZPyr2G+vzoXYf
 e0/cW3z3X9zndvm3cVqcDTN8zaMj/q/WU6YqoOqFMqfZqOiQ/KrG9SuWfe345gTrmw8fxTZQSiZ
 rzd6cv+iJfJhroufaOfI2lucWn3OddahNESow2PAYw7diYPWceKN+bF1vWIdcNelFn10oyH46+S
 dvxkdYcbG4z6285AjoIGmUeCs+1UcQwEw5cauflvz3vilzzyBZ/fmBOb4914n4Yxo4WKN8ZkWrM
 5VqtypFzKIcssSyN5Nw==
X-Proofpoint-ORIG-GUID: WF6FbRxdpDWgM1692YfOEPp8Fw9SCkc9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1NSBTYWx0ZWRfX6DxYI8mfYA4v
 /cKhozo6fk5vFzX7+XVWwvRH73J0P9nhDvlj75BpyU1RdnnRpQK8ndbcmndr+KJzZ+tioomGw3A
 B7QKUYiT7iAeiGVmKHvJIIesYfdfXMM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310055
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 29/8/26 00:58, Pierrick Bouvier wrote:
> We are about to change the filtering logic for machines. These boards
> are impacted and already are conditionally available. To not break
> existing binaries, we need to filter them accordingly with new mechanic.
> 
>  From there, we are free to remove the previous filtering mechanic
> without changing any existing behaviour.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/arm/aspeed_ast27x0-fc.c  | 1 +
>   hw/arm/aspeed_ast27x0_evb.c | 2 ++
>   hw/arm/raspi.c              | 2 ++
>   hw/arm/raspi4b.c            | 1 +
>   4 files changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

