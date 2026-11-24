Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B917606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EP/XosuT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cOOHhpiB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVno0-0008Jh-6F; Tue, 24 Nov 2026 05:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVnnv-0008IO-Qj
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:31:16 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVnnu-0002ek-B8
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:31:15 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8V2s9016912
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eW8w1EA9Y+cMbqr/QzVzeRx5Dx88wspMgG2Cv8DRMwI=; b=EP/XosuTpYgeGhGK
 60m3a3AY3kk8ab6NCVXQFP1LP9yQBagbssN7blEDQUW57pO0c54H96M2VDAH85Xp
 fGUN1lEmQESUmFwPjeDd/27igXfdPh8voJoLir+NijH6fxFFN2ZXBjTcqhYaVlvf
 zu4LyuUxrSauxP6K6X4Qaml2J+u/ktX5+WQhztSvKR40p308pGVYYsgCkHTEMB6g
 +Ok+A0jhSFbipUEToG6KJ/r6ce2CvDPrbQvdPIj/AXXTBVHJ+9orQXpqksei39hS
 cTB54qaKQGFovKFgYc9d+tjvo7RGoYtpI/3eOmPJXYC225YnWSruEzRI94H25Ski
 FPyBFQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4u9nubf7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:31:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f20addba1so685650985a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795516272; x=1796121072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eW8w1EA9Y+cMbqr/QzVzeRx5Dx88wspMgG2Cv8DRMwI=;
 b=cOOHhpiBWdD0VZ3kUfWMyo7zjDvTbyyVLchayeyjjUk3bI3slopHmcOwFpwmwnPcQO
 +TUqkF8ROjRJCnnOAMfx0mvz5AG9wdtidF84SyW2ZfQR2Bc3+19aK3mJvcGi0gK5c131
 mjjPfs1V2zr2Y0tYWiy4MITDAQlizZHJ9iY94u4zKoRFlElfxs0mWW8ZbgzQAvMiEG0s
 q5AznybQpNVpo3XWg4axTvAqYx7l6sHKpuCoEqXK2NAoJ7hswEkS6X90LjJ46MBxE/X+
 XtoQZsjYJYtofd1M32UlKUXJeAfYTkSqUqne4R8z2wEQ7ni2lCnFDdLHEnrBAN30ecge
 FpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795516272; x=1796121072;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eW8w1EA9Y+cMbqr/QzVzeRx5Dx88wspMgG2Cv8DRMwI=;
 b=Q1TdacEghc/nCXK0Kp9d8w5zZuppXNbSc7Px2+uHotdrWMJqo/QNpm/sbJsYdI54wG
 wDO+/hSXavogn5Cw4Lw7Z6EHUQrEJ49dPCLfzb58PA3TTWnOGUpWKNdQuHNfXncSNq4F
 lpG1xT2yDegpxMuwHh63FGSuehhQulRp3uemhaqyGcBbUtcECkQA8X9wXJRGXMW8Numd
 3NcHor1tt9AD+Yg7Co8V/wC7a3vqYLlVICdBF3AFxHp7BszB98qSiK8DkitNuu17/gI5
 6aOYtYncY8TLaJT9QTolexvU/fJwDWNiRGgLHVCjHHIZrfLS+xyEFJatwOZx+DXjGtVQ
 i0Kw==
X-Gm-Message-State: APuU4Z8G5Mq9G7QRiBiJhh6TwK4VTSgOabIsy3JGL0jOR/g78EVAwu9r
 hQr8KHx5tXUW0zf65blexcxk777R+p+ms12Qg/dVShcACLl+4bdrLq576vOSY2gDCU3cRB9Uuen
 MCP3sxCyYRa4SN4dngsVUHHS+NdWQX9trLbwFy8PVEQ6NmmiOQAy/O3bWCkbqd5VXD/Cy
X-Gm-Gg: AZFdTZeqCHpftPs5VQjkXuUAqnv/VjrPB5PH512or2KXMpuVieejye+1lKHJUfzjvSO
 0oi2iQ/7ZJwI4dLfwb+F8fNo5+kc9i3wxqoDToQLMXu3KmUuanFr2FEZDODpmga7h24KFa512Xh
 0YClWsdGzTqXS9K2t8mfXKhGPyxYFEbFdlrUVtbBeu89BLPSkYO25EJZvOhbJlOHfKO8HT6rU4G
 hH2iMEpALCT40vfp56rl9OXNSittBYBgwXWA9+FuyZxwFyyp17evLmyGEfqaiI9zpwVcv+sHulo
 6hV+KJlLsXb193anxIt7LTotrs17pSPSILzmAGzu+5uX00wpi2OkFZJ17qBCgz4JiJjCwnOWnwM
 hUgKVZFbhmlrIVOlXFflHfGPQ8wO1Rna+3bT1yLQ+Ux0Sonm7AMEVZEAJtjBslZj+DUsfdWQNVn
 8IF4roqOk=
X-Received: by 2002:a05:620a:3914:b0:949:7acd:3c43 with SMTP id
 af79cd13be357-949ba7cbbf8mr2066918685a.3.1795516271783; 
 Tue, 24 Nov 2026 02:31:11 -0800 (PST)
X-Received: by 2002:a05:620a:3914:b0:949:7acd:3c43 with SMTP id
 af79cd13be357-949ba7cbbf8mr2066915885a.3.1795516271299; 
 Tue, 24 Nov 2026 02:31:11 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf6804sm26758699f8f.10.2026.11.24.02.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 02:31:10 -0800 (PST)
Message-ID: <442bb22b-9da3-4147-8bd8-70c684100004@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:31:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 2/4] hw/display/vmware_vga: Check for bogus
 FIFO_STOP and FIFO_NEXT values
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20261124095719.4126146-1-peter.maydell@linaro.org>
 <20261124095719.4126146-3-peter.maydell@linaro.org>
 <69976e65-ae0d-4fe7-abe4-1894b4005873@oss.qualcomm.com>
 <CAFEAcA8vR=NuQaY7TMQBEixcMcgfYeQYmkuzbzQeyU8rCdB_AA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA8vR=NuQaY7TMQBEixcMcgfYeQYmkuzbzQeyU8rCdB_AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MCBTYWx0ZWRfX8mLe1v1PmnKn
 KM2wrUbXhSTXNzVOtSKAyR+ibUhYvn1KQnmk2wUxZm0/ZiI63Ym6yPujodRkZroJkJj49k8aIxG
 mHPC6G7rQl9a8tsFooZS13EUJud1eddqoKTOw7Ls/geaOcPYE1vuhH6AoA2FMiCm75tf5qAVamI
 ZX50+Hb9+jbjyyIlWE+Tgu+3tfBL3oCUPuMl6HEniTHNgt4SuMri/HE7g/9QJxvHwaMoLZJJf5J
 GKCLGymMJA6yd3xxOjjaJsLkyvVxzXW+8tVhIvHg+OdKShG2RY8i+L9HrgiNsUpd6kctjLgCc8W
 bLIb+LhqXohE2dowGwVugjoFVWe/px07t8Tl99xZSc2orYtfNUxcoujgh+wItQVRJL+zdVzE2ce
 eU0FWA67vppnL7+VeFhRiF6HVj7DGgmZ1uo0YduAkVl2twEavIj+Ou2lmdzshzVdGgQuSSLKDVb
 qIcQpI5I5oTwv8YG4Fg==
X-Proofpoint-GUID: mmqlJZbyqj_-Hn3H3BWaEjjje8cut0yh
X-Authority-Analysis: v=2.4 cv=f4ndl+yM c=1 sm=1 tr=0 ts=6b056770 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=aOqWgBEPRn-H-EUaD1cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mmqlJZbyqj_-Hn3H3BWaEjjje8cut0yh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MCBTYWx0ZWRfX5TQuY7OYuSiw
 u3FIqNoz8rbGbGbftpIi3SReQN1EDRCZu+Q0lzSw2saa9jrJ2DWNAEnM30GdIDeTs0mhlej9q3N
 mu7iXtuKuopVl1kSx/Bvw8k9Cy9k5vU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240040
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

On 24/11/26 11:26, Peter Maydell wrote:
> On Tue, 24 Nov 2026 at 10:20, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 24/11/26 10:57, Peter Maydell wrote:
>>> The guest should never program the FIFO head and tail offsets (in the
>>> FIFO_NEXT and FIFO_STOP registers) to something outside the bounds of
>>> the memory area it has defined as for the FIFO via the FIFO_MIN and
>>> FIFO_MAX registers. If it does that, return a zero fifo length as
>>> we do for various other bad values.
>>>
>>> Bad values here won't cause any serious problems as we were rejecting
>>> offsets that would cause us to index outside the s->fifo[] array; but
>>> they're better rejected. For safety's sake we add an assertion on
>>> the fifo cursor before we read it.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    hw/display/vmware_vga.c | 11 ++++++++---
>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>
>>
>>>    static inline uint32_t vmsvga_fifo_read_raw(struct vmsvga_state_s *s)
>>>    {
>>> -    uint32_t cmd = s->fifo[s->fifo_stop >> 2];
>>> +    uint32_t cmd;
>>> +
>>> +    assert((s->fifo_stop >> 2) < SVGA_FIFO_SIZE);
>>
>> s->fifo is a uint32_t * array, shouldn't we check the index as:
>>
>>          assert((s->fifo_stop >> 2) < SVGA_FIFO_SIZE / 4);
>>
>> ?
> 
> Yes, or probably more simply
>     assert(s->fifo_stop < SVGA_FIFO_SIZE);

OK. Either ways:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


