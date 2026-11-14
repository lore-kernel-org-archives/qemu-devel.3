Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5263C606A327
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gSJWJd4F;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J0mWeQNd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSFE7-0006D8-6l; Sat, 14 Nov 2026 09:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSFE5-0006CW-T3
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 09:59:34 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSFE4-0006cU-Cv
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 09:59:33 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AEDkUIi4115461
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 14:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FSzzRlAvObNwnscGZErSUDZCcV6NAKdMWWojaWvjaoo=; b=gSJWJd4FYNVxvTCx
 E75n4KIKURHa4sD6Oof8SmTQDRoLGE96FXXWhEBvBRULIqoZWnVG9ekCKNXPDvHU
 gKFyvX65w1TQvaCB0S1D+UnAol888NQ69SX3kKO/FLAMT0ARDRPjXQcFDYAtLiWi
 h+SFu0d7P9yqZ6tHMeJckEFLPV561wrh1kz6QYdX5Aos3Oj+hfdUdGwnYoBiwAXo
 XHAvQCdPUF5Pz9j3Xpkc8f5jjfxxMjEvR4NsHEq7VPY8/OJy1K45pp1z7saHoGgI
 1ubiFl42vj3GCG87V2uye/lE3VJAQeln4ts/efxg2Ct/N07+KUJqFbHXfSs5q8nZ
 p7UzfA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjs2uc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 14:59:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ed2c307e62so31955735ad.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 06:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794668365; x=1795273165; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FSzzRlAvObNwnscGZErSUDZCcV6NAKdMWWojaWvjaoo=;
 b=J0mWeQNdtgr6QOvo6B4MCIwrVO8zW6nB1j6ekdlA5r/Ww6TJkhC0rrnqxcPsGNvbtk
 X35Krc0fCCQPDLv33jA9EiurGpsdf5pO17Szi48bW31Fl04naIaHTZOuWX1U59+eARvU
 urF5a2RLNVJQ8YmNfb9yEjuaoEQH7SjkXx35tMSlmXSS0DFiHYZybBXUke5IU7gWcqfj
 FJM216iGGJHop/G1pLudqcdZ4lO6AqTXkW52FPjrILzW2ej4ho/Iq5Lf/m/lRDwKMfu7
 VvwcQoGbEtMZu/dhtUZYsFpWdp3Nc5pbg6PirFTCvbMVr4x4njUGsEsuS/tCd4fTGWpc
 JMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794668365; x=1795273165;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FSzzRlAvObNwnscGZErSUDZCcV6NAKdMWWojaWvjaoo=;
 b=bXsD5leU8kZe7eV4RxDhsCrP8sgdrZpBOmpxyZWP3cWK23f2IcqrWPplqP9xvSJgrt
 o6cn7uiL7RWMZ3NMXy+guvvxeEf89id8IUVNjMQxa+6xenHpukOhYpggquqFnNZS2Qcp
 ToEmjtYjTNxj/T/bpj7X0KCcQap/cHI3iCwlPjBcEFC4gUiLjOJBBibeFVgdpHm4P+In
 aogFX1LIoLWPxJCuD/rlIe1vgLNODu714fMbqP3o85EZ4vo62cyChE5jsdw1Wnfz30zt
 /loMYshpNTrDMZIHg3Ufg96dxkFH+LzY/F8344+bbyJ9U1Ro0XMnJE09+aE586/2YKrO
 vuEw==
X-Forwarded-Encrypted: i=1;
 AL+hErEjsagT64eyi857aHGbqh9RE3bjw1b1thpb8NniogEVZZiwHVg4AEej7cd3jwnc29Y+yYyyXWfet6oe@nongnu.org
X-Gm-Message-State: APuU4Z9IqwAiIYNF50I4Oto3dvh3Ip2YqCVHnMzbmxrXDMsENF69UFGh
 +1eaIW3WaDQvRK4Z+iz9FpCNHcIV14wT0KiDqMLPS49h0ED8bakKqsw0MZ0yYEHDiYrfsTMcq6r
 XBa100RqaNEagGIhJtidoGsBYWkxkJy0gerJHgFZWKiTUIf0gfTbW4wczeQ==
X-Gm-Gg: AYBFou2oi2fDKUvY/X2NoV6vKEsIicKiHI9KMjsfuv7H8zG1AIvyfs5isVJOlSkAB5b
 88A+hXav6kt9Gq6CUrLbsBNbno/Xj2ssi+4VIg7nCCc7Ybpxs3m9z48g34M71VlLQ11KfNvBbBa
 S5121bbCno68i51UPV7hO5dUgfPam9CFLJVfmaHIKvjjlhEHwG6EtrgcxiWmTVi5MM8Ab6QIKCw
 BQV8tSLeXL68qfmc7npzcMHvMkW0rlFAr7XlLsGvNUqS0k8jNU8ae3c7LiYuJOpwevOnlPSovIt
 7Vv5Hi9/pQijI6UpRg8wnxI7wM5AwUlwPBLiRWgTpDo+1seeXTaeBuqTQ1lNPgU2YQRJ2yGpvo5
 lGcV5B5HhX8yVD2M8t+D0lI7bLfU2zBqr282C3byahkYAuNI7JteUahik+Y4zasa6KQxJAvsF+h
 adi2U8b1OPWgopLDsTbMWojuxqBC0jXg==
X-Received: by 2002:a17:902:d98c:b0:2e9:5b4e:b8a1 with SMTP id
 d9443c01a7336-2ee0dcadca5mr55882225ad.55.1794668365043; 
 Sat, 14 Nov 2026 06:59:25 -0800 (PST)
X-Received: by 2002:a17:902:d98c:b0:2e9:5b4e:b8a1 with SMTP id
 d9443c01a7336-2ee0dcadca5mr55882035ad.55.1794668364577; 
 Sat, 14 Nov 2026 06:59:24 -0800 (PST)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7e5055sm21575215ad.39.2026.11.14.06.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 06:59:24 -0800 (PST)
Message-ID: <d471f075-cdc0-462c-a894-04bd1a097479@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:59:23 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pc-bios: rebuild H2 firmware
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
References: <20261112173901.3748880-1-brian.cain@oss.qualcomm.com>
 <20261112173901.3748880-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261112173901.3748880-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfX/ROMcj1Ysnml
 769cVhzOjyIDJZ1Ph0nRVgDMMUVIrj8bww37aErcJbMMrZoClP7kCA+GG7Hsui80JntVBjljL1x
 bE2CNRUSYnutJwC+DPze3hb2KRJywiKdLHFaIYeUsayRc71XhPod7/Tkn/BygJEaRw7rpGyfUXS
 wSfGwNhMiaqUoxl/cv0UkuDnoeLuy6BSQniTCl2N9j0iafU96vGIr0Xt20srlXpAijxBhSVpYkn
 HFRyh3Up8oBMuwqUhjueIcnNHu2yJTt3eaEITb6LL1oGPiIVfjfXhHQYgJbiQPXUEZxDd9bmWic
 ER8vwVf/sVlUOxe+l+ojJp7OpFOfnwaoOK5gRGrOdTzT9jwXYiv0OEe8qUIJAisD62ZydGMnQyE
 fNCvoaBy3Od1U2zDILHpCoVYhGpPtbsiJaycoAXfpiWcy9/Rd3NrzzdwwzWwk5w4taUxifNgPaC
 OhyLP4j4DOt3m9fzw5Q==
X-Proofpoint-ORIG-GUID: 5zhHbNBNK7dNUVavkP8ptTX8gNrE648S
X-Proofpoint-GUID: 5zhHbNBNK7dNUVavkP8ptTX8gNrE648S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfXwihny1fkezKz
 lgql9pDXgTjdzk+nbkZ4Auwke7QSMys8KGdJT5SZOSzBy9uSrOftcQxAutcYYQa17Bx5we7ZRWj
 oIxbqGHWXtVuDVulzAyQPKlDGLcGtrQ=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6af8774d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=v85dxRR-US6wc7jHZUwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140059
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 10:39 AM, Brian Cain wrote:
> Rebuild the H2 images with the updated roms/Makefile.
> The H2 sources and build ID are unchanged.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   pc-bios/README                          |   7 +++----
>   pc-bios/hexagon_booter_qcs6490_cdsp     | Bin 285292 -> 285292 bytes
>   pc-bios/hexagon_booter_sa8775p_cdsp     | Bin 281224 -> 281224 bytes
>   pc-bios/hexagon_booter_sa8797p_nsp0     | Bin 288904 -> 288904 bytes
>   pc-bios/hexagon_booter_sc8480xp_nsp0    | Bin 288908 -> 288908 bytes
>   pc-bios/hexagon_booter_sm8975_nsp       | Bin 288900 -> 288900 bytes
>   pc-bios/hexagon_loadlinux_qcs6490_cdsp  | Bin 200428 -> 200428 bytes
>   pc-bios/hexagon_loadlinux_sa8775p_cdsp  | Bin 200456 -> 200456 bytes
>   pc-bios/hexagon_loadlinux_sa8797p_nsp0  | Bin 208136 -> 208136 bytes
>   pc-bios/hexagon_loadlinux_sc8480xp_nsp0 | Bin 208140 -> 208140 bytes
>   pc-bios/hexagon_loadlinux_sm8975_nsp    | Bin 208132 -> 208132 bytes
>   11 files changed, 3 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

