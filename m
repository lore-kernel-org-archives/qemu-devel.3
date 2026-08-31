Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E27C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 04:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0tt1-0007wj-L7; Mon, 31 Aug 2026 00:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0tt0-0007wD-4n
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:44:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0tsy-00057l-O0
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:44:45 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V1bfql3239155
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 du1670PtZB0d9+bShrqSzB5zKrmBikvFtLAHDDzeI/Q=; b=jGRNYPQujBEibXoS
 lBPQ6aPFwXzUoemgCiyT/+J9kj7KiuR9oCgqa51AqhBZ5iu/4/2cbwhp79nX4rda
 RsRxglh2Ha+M5k8HrkDMVh07Fx8bnHzMM739OMNST/5YO6OeCV7MF3fRQK909XXz
 odwyecmm4ssJftJSBsA2iKtgzNMutTG1LTkGYx+7ejTQeQpBoTl4DN+Kfzkvgu+Y
 4tn208olO9k4FhfCduKuWIigMKu38BfAXJ+ezNemZLwnqx1Ndifs0e25PMznnLnM
 ahjxFgUltwRSMoOOcZN8JkODA/hjxuko35XAKPeEd4gdfoVRX6kM/TUvhRqcZGiC
 9KrDwA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv8h0un9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:44:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so267220385a.3
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 21:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788151481; x=1788756281; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=du1670PtZB0d9+bShrqSzB5zKrmBikvFtLAHDDzeI/Q=;
 b=WrhWttd8haM6Db6Bl8rOzB2/GDGGXT08aNMaIDgKrOTOoU9n7bbSlJYoLwDV3Q5kXQ
 1sETtAanzWZ8lRos9O8dXCGe5naaPaE6Y7wa/pxEN58pb0rPGikcOfPAiWBb/OHUMuYh
 mCBWxY0kzkdcX6d8IGy9z/Nx4jLPQEr12uRKiSMgDDZx3X3SkhQ1X+I2nhDiDOnPXkYh
 avPukFskGnaCB/MKBVsS+glMEaLUUlhotcv9+vt58ULCZjD+KbPGNWCphPw3IicgdZNT
 63tseAGIw/xuNih6180ONsFWSz4dSz4acwdARrc6/3qHjQW2L2Ibm/uaIbzB2ohrmuQB
 PpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788151482; x=1788756282;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=du1670PtZB0d9+bShrqSzB5zKrmBikvFtLAHDDzeI/Q=;
 b=bgF5vtPwnJmvYb53nzaCHGpKs9PqiIAQLR0bcYYYghdnhNyOugSlFsRFxPCT0jbA7R
 5LTxcjCM2vOFzlJteA+w03AVHJSC0RM1E1s18VX69nWBr5AIWJc27iXJoyh6qS6i6oUD
 Gr+CMUetiL2d0xADdSGbNRCiMlqecsQYjN2dwKZ24SlaXQndx7fzWEATLUAN81pyoRTg
 8I5wZCzan2DApOeI48WPbQtYYGhH5ZCmQDKT112ynrEopnIEPjkvr/IoHea0gZ1nkaD3
 WPB7J5pg2KFmo0Bs8EdtvzNVuMcrjK3TwCGOfEkLQ/lvM1dLiKa/baxlHamK8I4KX8JJ
 BPOg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7pf1yJAKv3s1aQpDBTUwxnMRwdVySq4MgMJX26lypwiNXHxDvkosHf+NhLGKkIlBU3wPi11kk0smg@nongnu.org
X-Gm-Message-State: AFuF++lvOENwnbQkqPIG+1ie48ewdBojXq7K4jf8y6Phf62dfiZ0dh7q
 5aZyWr70gVmkLsP/upnNWxJIb0PMkLql32TJg+W7STkIfW6fnTytRPVnSD8YW+o5t4AMd32kMmm
 0pQl4Ee9zO2ybiLVYzSkOvC2jP8tVWFh6Dnwi5WAOfnmSuE+IN3L4lqtACg==
X-Gm-Gg: AR+sD12l+JQaEdY25XwOsllOyQxR94tWld17+G4CK4Dj2xIy/Fj9PmDBMfnbq3Z7Vb6
 APVGi9VJpDLOPjlxB5MTKfOWVj5L2dT0buJ5sAHTHuei2YzpN50sceWI2w0lo4qboQuvGADtEoM
 HaMKYmOs4/i4/0ipgiesW6PMuuJTKcyC0f0rNP+BH/Asq/lr7SkzyXsmeX/j+Qmxcj4tNcT8tvC
 JgQllU0H4wWfDJuc0O760TIsC30tuFAZG8xIJcl56q82hQzAKxqvmw9hs2ave6lxVIJYkiolNgD
 XyhuBwPYWqn6uDoL3XRWxpfWs/j0m2m/BxFJDFXjPt42qcHQe8l0cOBibw1yF52raMGVLcysXoE
 ulhAZQyTMR8dSIN4NatQqo1gw769abbzmpw==
X-Received: by 2002:a05:620a:319f:b0:939:2af8:5be1 with SMTP id
 af79cd13be357-9392af85c54mr1167672085a.4.1788151481653; 
 Sun, 30 Aug 2026 21:44:41 -0700 (PDT)
X-Received: by 2002:a05:620a:319f:b0:939:2af8:5be1 with SMTP id
 af79cd13be357-9392af85c54mr1167670485a.4.1788151481256; 
 Sun, 30 Aug 2026 21:44:41 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95018ee8sm253997245e9.15.2026.08.30.21.44.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 21:44:40 -0700 (PDT)
Message-ID: <51909b26-19df-49ce-8985-e79c200b73e8@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 06:44:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] target/arm: Introduce cpu types max-v8 and max-v9
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
 <20260828222639.1432046-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828222639.1432046-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DY0nbPtW c=1 sm=1 tr=0 ts=6a9506ba cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDAzOCBTYWx0ZWRfX+OeM845i6Gf9
 Yhqcb70sY6oEPcSTZcNHmLXZgwUGsaNe5SjVP1/00q3mMw6PVjeMqTya4ohs4dicosRFgyn11Lg
 2KG5Mp6eS3Xz/20A2RtZm9nQNfcTmLgphHN0cZjwbe0oQtSZN6tjPOJVKB+CjKT9b5iWI2HnXv3
 fDIze+YGZQZNjWHj6ajxKjjSnJF0HMDdvnARP8k+O1llVq0fpozeUOCgTIQKxNCvM738oKvLgOP
 7KeHS+UXMejW+dpoKFJV7YOAJP8FlVL81KreiVNwnEeyX0lx0Rh96yh97AyOjflMJxVDKffCKj5
 jBHtSOdHZTayZzBtPz7F+mbvJrOltZx+rzN1XS8Ai37ykb/2u77R1rQNvL3JZAlaZSO6vDIGNrn
 BRdJlgecaHHmAPOxV6f6+r6zZKkmqT6IVTvLEliKGWJ0d4N1m9rMgGKHhSDw/D/dynHxk+9JUrv
 POWy7+1G5TVUVMT0djA==
X-Proofpoint-ORIG-GUID: QjkMIdKQWM7Dg1nfL9VL3iKhEf19WQZv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDAzOCBTYWx0ZWRfX/h5JFLMuu5Ok
 T4M2BW9r9KJJKOQjogUgxqwsfEj5FpKX3sJyCBXvQ8o6xcJddIXC/ABHFyZVilhExonNNyTTapH
 /7jnoYh82E+a6iJ9quduXP/vPCOMMrs=
X-Proofpoint-GUID: QjkMIdKQWM7Dg1nfL9VL3iKhEf19WQZv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/8/26 00:26, Richard Henderson wrote:
> Introduce the names and allow them with the virt and sbsa-ref
> machine types.  So far, the cpu types both exactly match "max".
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/arm/sbsa-ref.c      | 2 ++
>   hw/arm/virt.c          | 2 ++
>   target/arm/tcg/cpu32.c | 4 ++++
>   target/arm/tcg/cpu64.c | 2 ++
>   4 files changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

