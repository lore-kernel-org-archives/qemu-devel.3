Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F99C5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8aW-0007fy-0B; Thu, 20 Aug 2026 15:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wx8aT-0007Y8-V5
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:38:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wx8aS-0006vK-BW
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:38:05 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJ35j4117203
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3F7m0bphksuTWboa6iLDj6M4eLWPH3kCX0sUS+Tf77Q=; b=cj0l8rp4rba+Qbml
 tw3HYVXcjDIjWPbw2eD9QM4fSIjJRl8CLku3xZrQUK7ToMENd9IZqRwhUXxjo9eZ
 3Qw2UGrZCklDwqKrgFhYJ2L7opvEx/xfFmX+z9yiKHGHFO8d6FhqZZwPTclROEHZ
 iP3eA64tsVwkp5VcOcKfE3o0U3OZEDdcsaq5zmelyn6PdQzRa/C7caTDpXSSE64j
 c4VsrEMdx4Kzd/Fbj8mQreLno9w5XBREvE9M3X3IaQwFnKhgLx+EKE2mB3tEBJGR
 tmkwvkJggM7lbEKMiw1D6TQ6+U9RZlXzqvG1LutbXdBRVMaKTFtvYEK1hiaAYomK
 LfouSQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xuk2u3c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:38:02 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f1e4e0eac1so1877336d6.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787254682; x=1787859482; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3F7m0bphksuTWboa6iLDj6M4eLWPH3kCX0sUS+Tf77Q=;
 b=Ft+Zs5RYl/ZeDhKWk1In+e4K4gWndKzPQkL888y/RP+enBUgx3y06QByJrNRjUHKwk
 rPiXRRpQU5kBMQx2aaPySTMPgKckP4Q7SdCto1KroxhxNZft4Mzh4sMvDy+GzmivBkY+
 Nm3RXEFWpV167pAFfahsDQhoAc8X+uSobYLtZQKqIG33PdwoLKxLY7Qec7BahcNzxH7i
 RIBc1oMVImXZH/x2S3khfpnKrSCniA8d98Jd7PUUtcn9dFXn2Ym1YzLFLnE99ajwsKaG
 /hy/266T/yfGzAqW0JGTI5hDGnkvUzfprYATecvn6JAxnK/hx6PyHmTiMTJzmUozb4ip
 ffUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787254682; x=1787859482;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3F7m0bphksuTWboa6iLDj6M4eLWPH3kCX0sUS+Tf77Q=;
 b=PDPegjjJHyKxC1qRVlod3joAMTPYZi0Kg12S9QU0l7WpyFnXe2a63cj3rVDbbTF/fG
 b36fr+zGCql5msotNb4zXzjGoRn8GTUHXSYaQTLT41F3YsVESu2ERH81+x6VDcGK3zLc
 AEZUUkKA7MXA5DwY51oYtTlK9aeJuf+Cp1huVkKsIGAHL36pC7nq5wxsnZQDjP1tGBdM
 bIWe3XxtIff9FhQj2METqEBqqtAtBOBXMWe3KlaEXoJFUA0+LH569fGzcgFgRDsvn5lY
 Q12QPOlkc0TYA2757xTCbhiKlo30Zpi/MszsQiJDpCwpHG71RKCpfOxT0x4v5EyNcxdb
 RJOA==
X-Gm-Message-State: AFuF++mGaCVlkpFRmKu7DUsyXNeQfgnSs/WXZckfErbsBQ6Y0YxKcjHF
 6KQSjSSHwszifP4Hr765HK5et4JmuAVnYVcHjN5USTrbEvJ+0M18a62cI9TEE7OuTZTW8EhGWhQ
 /CSdesARvkhankYf1CppB2GKlRShlk09gO/uCwYBAlBgeBYvcjx5jvaAr3Q==
X-Gm-Gg: AR+sD12nAqkwaMGERHmuiLLLRQedQtuxLA8vnOEBfHGiBtOtbjCeM5OFm3AqPtAerI4
 JhMnTQ3HQ4hDVV7vIUC7EjxYPsyZGRbyc3TxQTyELPOGYNSnqlF+Qd+t3KBghiB9cJrZmKbgUBu
 KadGsPhDwQ0SV1SoFrvoJ9nNPP4Es/zQlKiMEZJIEuNJpPiK+A8TVQyhoGkbvYTpGlRI8R3zi7V
 g1rv5AZ2WXg8TCTq1xUQ9BKNp7CEXPwzdbUMpvipBH1HHBKQTY3sGnakWiZ6iNEqxCcVEIBT7lq
 Kl086Y/itjXb+pj2FD4/FucEYjE1phFvrf/XxssyYpUpsuQXqfY9rrMgcEJppfDh9xCt/hSoaxF
 1pb/xwYh9bE9uYUv+7qjP6RU1nwBl8yYZPKS76Z3mM8fy3VLbBuP/l49RqgNmnnUt
X-Received: by 2002:a05:6214:2344:b0:907:840e:bf11 with SMTP id
 6a1803df08f44-90c8098f7d6mr6015496d6.10.1787254682230; 
 Thu, 20 Aug 2026 12:38:02 -0700 (PDT)
X-Received: by 2002:a05:6214:2344:b0:907:840e:bf11 with SMTP id
 6a1803df08f44-90c8098f7d6mr6015026d6.10.1787254681787; 
 Thu, 20 Aug 2026 12:38:01 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c6b42455dsm27380866d6.37.2026.08.20.12.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 12:38:00 -0700 (PDT)
Message-ID: <82275d79-770e-49b8-ad17-4e136c8273e6@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 14:37:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/hexagon: fix HVX big-endian byte access
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@oss.qualcomm.com, anjo@rev.ng
References: <20260819230939.466856-2-brian.cain@oss.qualcomm.com>
 <20260820150239.3061104-1-matheus.bernardino@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260820150239.3061104-1-matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kKjC5Lr2TgTeSFUSLAwyy_Fvy7CG9Ztq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0NyBTYWx0ZWRfX9ulrahjAELxp
 xzwI5qX74J7TbQXUCgWjytRQEd9M41S70IxbjXTOl7ikmb1WwIrHTvcUjGwXWVz/8i0YJQTZmwc
 bB18DfgsF8xVNiJ2yHEt2NXjnm8dViQ=
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a87579a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=IN7JBnBnK5oxI6k1dOwA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0NyBTYWx0ZWRfX32McMapY3D8z
 xlL49vFZgk6KSClb8QDwiiQzjODVjg6HL2EIXm9aBykjxkrGP2fKOwNHKolBOvUgqtNvdAsFwtd
 GlluHKw7Q0Cv9ad4x3wpU63RcFMyXXFf41G57mGE2pGOA/NCi5hixrWfZD1qlDNIHvOdo7ULpVF
 ewxPWmpjvuf9boVqBzB0cpBMSi+W2quNK3TozRI+tj44WaGDn2DwEbKoBlw5dbLhyGNt45FWgSS
 jQuQ46ZPP+lcyn6cznutZcq7OVclwL0O3nRwIX4q4neYfuU+fPfu5QRIV5R2AQZal/GVAZWORmk
 Og0CuFEeo+YO69XTS9to1f4byI2HibqHPH06jGZWky/0SXqQt6wde0blbkLElrgYBMe6CV15qgo
 rvtzacBbplzh+dOokZZeQZUcjAGqK8yGvuKMyRsN7YwABskHyUQ5XEtWZ15E7YEfeCyn8yl/d6Q
 ZUZlL4wUqNFMh0TnmCA==
X-Proofpoint-ORIG-GUID: kKjC5Lr2TgTeSFUSLAwyy_Fvy7CG9Ztq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200147
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


On 8/20/2026 10:02 AM, Matheus Tavares Bernardino wrote:
> On Wed, 19 Aug 2026 16:09:37 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
>> index 8e72f2f6ae7..a8a777812b9 100644
>> @@ -69,6 +70,23 @@ typedef union {
>>       int8_t    b[MAX_VEC_SIZE_BYTES / 1 / 8];
>>   } MMQReg;
>>   
>> +/* Map architectural byte indexes over host-native HVX lanes. */
>> +static inline uint8_t hexagon_mmvec_get_byte(const MMVector *v, size_t index)
>> +{
>> +    return extract64(v->ud[index / 8], (index % 8) * 8, 8);
>> +}
>> +
>> +static inline void mmvec_set_byte(MMVector *v, size_t index, uint8_t value)
> Should this be named hexagon_mmvec_set_byte to match the getter?
>
>> +{
>> +    v->ud[index / 8] = deposit64(v->ud[index / 8], (index % 8) * 8, 8,
>> +                                 value);
>> +}
>> +
>> +static inline uint8_t mmqreg_get_byte(const MMQReg *q, size_t index)
>> +{
>> +    return extract64(q->ud[index / 8], (index % 8) * 8, 8);
>> +}
> For QRegs, I think this should be:
>
>   extract32(q->uw[index / 4], (index % 4) * 8, 8)

You're right about both of the above, I'll fix these.


