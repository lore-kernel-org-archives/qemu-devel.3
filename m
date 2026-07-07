Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6529C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh8aA-0000C8-EO; Tue, 07 Jul 2026 12:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh8a3-0000BB-6N
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:23:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh8Zy-0000r6-WA
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:23:29 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTmkg3996890
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 16:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lq0CTAphc2z+JHkGGdvQrcz37RSO1IPCVryUln/+Ls4=; b=ThZUBEWlWPBlbO5S
 SCnD/uTPoMW0Vr0dFxIZXtLafQL3bkZQwOKKWy4cMDW7ajZY6Gv/U2fr5Th/KdCO
 5Zczyu/fCQ03zyCV/0231USG8IK95vT1LcRCYHAYNCf+HBPKb/vqqe0O6FH8nSwy
 zF7/mAcT0DyC0X6Ky6N7JtIZxlWdXDDeUYoNuAMTnogYAn/xdrBWzXGcfjDxjpk1
 VLYrqKP6LrHV/+bae7IunBNd7b34zskhfMI1fqMew0zzvs2stigRGQUxFQHwWkGN
 dt5DfbEFjwUfGt7F9N+sTmzyNLdTUQHTbHNVS7u5ZUuy7/JK5sq0qkIz+ZEkdukY
 PeqqQg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su72xhp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 16:23:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cae455cf6dso61032785ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783441404; x=1784046204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lq0CTAphc2z+JHkGGdvQrcz37RSO1IPCVryUln/+Ls4=;
 b=WRzPoKoJECrsqiwEoUWeTdYIffMlY6ufrgIXpqQupPnPDl755M1Be+qS5xcsjlBUgU
 5od35zYfSh5ff8jCRkaJ56ebjYQTxk+47AS66YermMkMKt/0MhNxf/xELIxz408mtril
 c3xwN3BZkeyTVIg8goSGfZ5cwjmv7s/dyWNfzvmDKkqyhNl44qHnYo5MNWg+k304cg4e
 ojSo6CTDfUC/QFlOsyQt0pbkVj5ebHE30I6n09c/ecCA260RiHJwlc7WqmGUER1yYEse
 Q/zPLXHJAWxowJBXO+hQBcktNdiQHZPnD2i62LFGRNns78sEVHzD0GZXhUgT04Vhrb13
 S+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783441404; x=1784046204;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lq0CTAphc2z+JHkGGdvQrcz37RSO1IPCVryUln/+Ls4=;
 b=ggi5tOKGXhmXlzCe3QPDDk2KUMcryqikRzCSr5GtD1iG0f0tMYsGL9NpKQWGqzd4QI
 EAi50/keU0mRWqOT5O8fiW/YKckqKlZqJpxYCNHgWb53fY+vdc38bbt9B7+E57BXnZV1
 48W5mojNESfbPb3Rffv7qyGPTaB/JSC7rIXqj6BC3KTGgZDOfLCRIECDNd6SnvbH9LeU
 bvPsvTcRZYbjBU0YjkRI4dUKaRc2HuxwDkJr6dRaz+TwBo4PMfvrUbcFccHkin+pBfg/
 1dmbOmdn88y18OlEXq+9odFz+yEJy97KMYRPYd0ri/jPRxOe9VysYmTJZeDo/nrIjryb
 jl9w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8mpe0bhvdGkFs9ORySPUvcKitXnbI3iA+6oxWRH+Nlas8XQFcsBiPkmy/mf01uMPvFGr18IvE865N@nongnu.org
X-Gm-Message-State: AOJu0YykbURmoEJrEAZh8Ng6BTS5TVOcESarf2xINDPi1fJswhOfoTG8
 dOa9cIL3BHjnIrN+O2Nz1h+cG323oUtoJMP7+zLq44SD4rIpxt52JUeiX2zk91wacKh1sOS8ZHZ
 qsnp7gFxEZ+5YoHSrTurBxiT2TBstzae2LJPQxsK21LrqD47GuKP+hFpZVA==
X-Gm-Gg: AfdE7cl2VbZ97uRBO5Z+4/2Urnw5mTMw/Ao2Vj6kQX8OAjTqjmsm3YYg0LfN+1pjjOu
 39dJoeZUdX/5LBibpKsJq7s3WIbPHlgL5i3Dnv5iISv/WrUcfsexa9+V8oYHKAVnvMfPW0p1EgP
 QLZsUbb0kGE8VYS3iMPgaTxxlU0V63Ohjto69hzyrgzhvI9AP653ac0w1mBGRkS6ifgefzmFbOG
 zXI+5YMLx/01JKttr60QBlK8/mvbNR+VUauVjJJfR7za048mWOP70eErWmBatBYauvqi/hhpHiT
 UjSTSUJL4hyCGHdkxZWlmuiGu+FsPcomHyarypEgYi/HY+0zgSJeG52BmxoKmXQawFf1/TAQvsQ
 0DTbqAgxoveh8pYt3mvzM7t113v/bLjCsNGC2xGLo7D61O+o9oEnbLhylHIhrzVTc9Rx0NCpQlE
 0Qrfo=
X-Received: by 2002:a05:6a20:4e92:b0:3b3:2703:115 with SMTP id
 adf61e73a8af0-3c08ed8163cmr6832591637.16.1783441402767; 
 Tue, 07 Jul 2026 09:23:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:4e92:b0:3b3:2703:115 with SMTP id
 adf61e73a8af0-3c08ed8163cmr6832552637.16.1783441402273; 
 Tue, 07 Jul 2026 09:23:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f596asm9654229eec.2.2026.07.07.09.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 09:23:21 -0700 (PDT)
Message-ID: <d9d2de56-f2ab-401f-b09f-e79389e4321f@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 09:23:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 62/91]
 tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k toolchain
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-63-pierrick.bouvier@oss.qualcomm.com>
 <92481686-c1c8-45bf-862d-381b3bcc4341@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <92481686-c1c8-45bf-862d-381b3bcc4341@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MSBTYWx0ZWRfX4AuLNd1PsJQh
 OU5BhR39ILhyx8D8KOxIKJnhyuoI4Y5wSzJj/n/RX6e7GBCZ1Q3GxZiBmQgJQKrnItYIm15bPcS
 FqsHUCogzfvxqZjxTgp2C6+OqpmhHyPl6e6NlAmCLS7iOM3XOcfVOETn2C0DSQA1v84V04CMBdq
 vyTQW72GQCWQF5m04LpG8oif/2LkiKxRcEP7HWSnZU/RhN7AbUypCECQavqJcuoVWdc/F7khglA
 jwhURZLYiYBnZMfM1/mTl/onWir+AqO6+idOsi/ZfOJDkJx1XhYZRN68cXISgoi1arwoOo6/sWD
 Zs1w8U93Xh2bR5qunDgPaNPLsr3ivkxHUJ+0W+2ot1QpNLAe6ikJxYpMvKnHJdRrhOzccw1HNsC
 JsjFg6gMre0a9B0P2UvSJ99pr95NNOAGNqJNFvZ1CYL+ICmZlGFeP2/WoU6iVGqVtA1bedMVD8Q
 qBQm+wbBfbBoEvVAe6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MSBTYWx0ZWRfX3Yh8rtxWKdQX
 HacVqnWpWJb9cTR8n1dETXSRpSbVncftMYkUM/DLBofhQIW3H1/b7+0mnqIfsdw4jKk86WWnRgL
 nd9/3IA3J3wmF8u/GxobPXmMIO7OqnM=
X-Proofpoint-GUID: 51R_1uIfwhOSojrBuG8FuzSWjzKO3olk
X-Proofpoint-ORIG-GUID: 51R_1uIfwhOSojrBuG8FuzSWjzKO3olk
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4d27fc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=xLeswVLvbAFgn3Rj7rAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070161
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

On 7/6/2026 11:23 PM, Philippe Mathieu-Daudé wrote:
> On 7/7/26 00:33, Pierrick Bouvier wrote:
>> To avoid escape hell in tests/lcitool/refresh, just use a raw
>> multiline string instead of a list of strings.
> 
> Could we have 1 patch for raw multiline conversion and another
> adding the or1k toolchain?
> 
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   .../dockerfiles/debian-all-test-cross.docker  |  16 ++-
>>   tests/lcitool/refresh                         | 107 ++++++++++--------
>>   2 files changed, 75 insertions(+), 48 deletions(-)
> 

I'll send also another series for fixing missing 'apt update' in
dockerfiles, which will conflict with this part since it's concerned.
I'll do the change for multi lines string there, and rebase later on top.

Regards,
Pierrick

