Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79C606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O1pKwyq5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UEW8PpbC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSzx7-0002oW-9Q; Mon, 16 Nov 2026 11:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSzx5-0002ns-1q
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:53:07 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSzx3-0007kE-Er
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:53:06 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGIGGj2126178
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SGrSQ0Uq3bvTEOP4q0rAdK86bZ6OFP+uzHZaLIaOk2c=; b=O1pKwyq56KqeQxXb
 LAi94M9TX5Qfk+oBgGmpQp+HNu+MMdUeg7vHFfvcR4l6r5DaKTJgD3YVq9OEHKfZ
 CijXJpunOLwNYH+/Q2Wt0bOTUb5vPp3+eYrZIAq/MY5AnPPP4e+/rJMkqsv7WC6x
 tTClVceRZ28c45JV2KtjWFoZMADhXwx1SzqD9c3+eSoZ7CtvKS9ymNM4sgKrKyuS
 nyEHz0hwTTbXrU/zO1ybsuaQ4EmztfrcgJD309CUMY3cxtM5VfHXoFR07P9RQvgx
 95H1oZSkZWA4IGW9nMeFWHHq1IvpvfCjAJLQjlMgX4cBcWkB+LBzhKZSaaERuS85
 oVu10A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2ht2j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:53:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so4666560eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794847982; x=1795452782; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SGrSQ0Uq3bvTEOP4q0rAdK86bZ6OFP+uzHZaLIaOk2c=;
 b=UEW8PpbCnNe+GNZcT0NWkS53CGyj38eym2uB7sXO78mXC0ii1PWy0WYi82JkzheWDB
 c/3xE6lgz+w0ckg8w98OKLP6HQyIOocWUdrlpOh2fISbE/JLEeqR2Gltw9p2MgYrpuM3
 a5EOval8OFNQzWb4g98f1X6LMxUi/qxaHpUUmTDlM6tf/2JAl0CC/M3P6u4f5dDfCdew
 orrMYfiuTrNrOZcIVyrBK9D021c+tIXqmYpUOMV0uAsXbtR6XjWhotvZE8nEYozrG2lU
 lEm03JBZj8s16TtI+tzPkjX3BnPJyj+VamMoicHRcBvvWk4OeJx0y8NjCesLURGlzuuO
 YSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794847982; x=1795452782;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SGrSQ0Uq3bvTEOP4q0rAdK86bZ6OFP+uzHZaLIaOk2c=;
 b=BSCVlXLZG0sD5eDoDg7Nbaio/k/PxtkyhQHEBs+yphp9Dxokmd7U6Hia0eELuVMFQf
 yUVbiorK2AZk6E1O45B288fJCtVLl7kDOzNAGRV593UUv6FkTyGI/oMoKrnWWMu5w71V
 xFQ0auoiYrObuCDdEgrDcaCfo1pt+8nFPNjIrYem8mAOYAhlMh4+CxkjGP1dPh0k+/b9
 /9FA8+pjAdDU31w1FITTORzLqi7lE//DBX+3rnLxtP/bWTR393f1OBQWJHBjSmbtSMjD
 vuxzurSkLY8f16uDUbJrRytWHVdfNz7/F0rVXwB+U0pHk7Gp04a2LU1/y9E5CB3ciwdQ
 MahA==
X-Gm-Message-State: APuU4Z9CTq03vuOcATZlSJTU7ba9FR8m/nf1oBsnDzPVURPGILKEr2fk
 9ryhu1jOHchOuJKXjmb1L4TfOWOWgsaYBaRCHOu6OLDztT2SUGsfhQOneaTqQazdV8mbwQUoj4D
 tl1zTbix3mRId+JXgJcS+g9gPAxVK20taMybnGvl6Gy6qg6QTbaVtJEjPwA==
X-Gm-Gg: AZFdTZeqFlQjQ8iwSIqaUZQZXcAlXufhBcria7MX6ZSoziTqr4XHTUlbrtIf+iw0RQe
 ueys5/hqfr1EzmHItp4iCOEcTE4fhiWrfWL85bH6AYckTiyIUvoO4TuuvTvxeqfjHfwUscEfCnj
 R32P3C6wUszio1kiLN1Z6tkEJ0rmDDDW7ZDMC4tl2rTVUhAIVVx7G5XhkCxSBhaiNEi8DVL9Ply
 YJajFWEb/eNxMp1gZhz1PQ0FsV/jGtzP/OV8hyycb3Md+GTmdikT9X0WdjdPMElrncq6QG2050F
 XNm9X7W138tSr3y5wESMMT+aK4kWgafm2n50q04ZWfZHGYZUPM0DIrTJdedTkf7b03PEftkvu7F
 zsv6DE9qPsgpg4QZeTs0QaYe2t5gTleJSWBTK7YiRd/gYShNRy/dIMYudq4XICc3312m7ZY3nsz
 SbTOUOtkW0mksvUzySv8I8RYOvY0fNFzYmzMsAZ8pdMns=
X-Received: by 2002:a05:7301:a3:b0:380:cc54:9b6b with SMTP id
 5a478bee46e88-380cc54a8c7mr645559eec.40.1794847982395; 
 Mon, 16 Nov 2026 08:53:02 -0800 (PST)
X-Received: by 2002:a05:7301:a3:b0:380:cc54:9b6b with SMTP id
 5a478bee46e88-380cc54a8c7mr645527eec.40.1794847981749; 
 Mon, 16 Nov 2026 08:53:01 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378c2fesm36318794eec.1.2026.11.16.08.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 08:53:01 -0800 (PST)
Message-ID: <3b98d87a-28fb-45f0-9842-baa2fa9deede@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 08:52:59 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pvg: disable by default
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261116144951.71940-1-mohamed@unpredictable.fr>
 <6784d934-1efa-4108-8582-e9c237fccbb3@oss.qualcomm.com>
 <828E220B-6D3E-4EF5-A800-98069538A545@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <828E220B-6D3E-4EF5-A800-98069538A545@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afb34ef cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=vTAsydGlsh5x0deyZPsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NyBTYWx0ZWRfXxGZIRsblDHqF
 b5G74TGsacURIW0hZA4mopfkRXdv74zKEIT2UjLYQAZ2buRdWGBUeieylLMVwU8Q1B3nj9+on5G
 FQXt3ZowXpCIGhH8pBZCh/a4gkyPjeA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NyBTYWx0ZWRfX45wmNhVUF4p6
 3nAfCUQcH/VOpF1TY6Pg2xDY2AQKISt4cOrJidkJRMZEx0/V+u5rJi7r0VwKPdJgTd6X2jNorBd
 J78p8c+GbZL8/b4RDcUA9yV5+juWI3GqewthQDzJU8o5FuPvJt5Zm6WMcmENqwH6xUzVzK98pLv
 1KfS8+HVHduItqdXWDhTwwLvKBcfj6sGqYIfSQp9ky8XybUsZhJZu3GmcPju7sdEC4MrtN4oewh
 mUfN57O8x7r79MpvSptXLWZBLMqE2U/Ti8SYsHCVz76dcJumrXiOaO+pWA7fuCGvNXD/Ts/caNM
 2/nBK4/LzbJ39zM/ynC0yPURXYRwG0fK7WoEEKJi2nwk+yAPd7HeXQFUMSPZM26NWa4z62Ez6od
 ap6Qas+M2WmIBu99hbnKYzidOo3m7gBzawbeX3AWZXz8XcPJ1Mm7ynKCmOscQO2eezA/RzRNsO/
 MevS/w+HLaJwD6L/3bQ==
X-Proofpoint-GUID: gjsk1ExhFP_HGZS-7wzi8-B5LhXRCJuF
X-Proofpoint-ORIG-GUID: gjsk1ExhFP_HGZS-7wzi8-B5LhXRCJuF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160067
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

On 11/16/2026 8:49 AM, Mohamed Mediouni wrote:
> 
> 
>> On 16. Nov 2026, at 17:45, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 11/16/2026 6:49 AM, Mohamed Mediouni wrote:
>>> macOS 27 removes support for x86 processors. As such, support
>>> for ParavirtualizedGraphics as a public API has been removed.
>>>
>>> Current QEMU does not compile with ParavirtualizedGraphics enabled
>>> and the arm64 side of PVG is not documented or supported by Apple
>>> for third-party use.
>>>
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> ---
>>> meson_options.txt | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/meson_options.txt b/meson_options.txt
>>> index 0d4907a0d3..eb049479f0 100644
>>> --- a/meson_options.txt
>>> +++ b/meson_options.txt
>>> @@ -208,7 +208,7 @@ option('lzfse', type : 'feature', value : 'auto',
>>>        description: 'lzfse support for DMG images')
>>> option('lzo', type : 'feature', value : 'auto',
>>>        description: 'lzo compression support')
>>> -option('pvg', type: 'feature', value: 'auto',
>>> +option('pvg', type: 'feature', value: 'disabled',
>>>        description: 'macOS paravirtualized graphics support')
>>> option('rbd', type : 'feature', value : 'auto',
>>>        description: 'Ceph block device driver')
>>
>> Sounds like the only thing we can do for now.
>> Maybe it could be a proper check in meson.build based on macos version?
> 
> Hi,
> 
> It’s possible to use a newer SDK even on an older macOS, and the new SDK
> can be used to back deploy all the way back to macOS 11.
> 
> So detecting the host OS version isn’t good enough, but perhaps detecting
> an older SDK would… but not sure that’d be worth the hassle.
>

Ok. I feel that people on macos have a better trust in Apple and culture
of updating system compared to Windows/Linux, based on the few users I
have around me.
So it makes sense to assume most of users will hit it, and disable it by
default.

>> Not sure how useful is it to enable this by default.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>
>> Regards,
>> Pierrick
> 


