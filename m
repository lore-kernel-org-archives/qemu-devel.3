Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24266C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh4xE-0002Dd-0X; Tue, 07 Jul 2026 08:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh4x1-0002Cv-7J
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:31:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh4wy-0007tA-Mf
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:30:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8ei93616557
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 12:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ab858FTsqpKQS3LHMrR2Qe0R0TjRW7W5vkNl7SRbaiU=; b=OmU1ovFv+WEF9tn/
 zopIaJoQjpwBWjvBHvrdjtRGfA46VTFBbfbPeKHa+IYu0T5Dh4uz5Fw2xJxM/6Lb
 7vbM0FF6we4NvJilZCLgpeN4eG+AbLgDxjbhl/mhV+JAvwnzCgSR6N/+r2LZuWFn
 7Rg5b+AOjYTMso5ewqG7bqtjVe9sSm7ndbt1JMueKF/HcHlMZiOHCZoNgeN7g7Ab
 bjvKxqgB0aOaHwh0vq72dq8V7wG8LQvgJXKq98A93WKCvyM+RmXupMJIFnvwGI6R
 T6hi0rNwuTxttE/uLIibPup2yzJy0PDRFtIC/Chea/Pdc77d1DJrgEK1ICdQ6lye
 Gyj9Iw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun17vf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 12:30:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso86391831cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783427454; x=1784032254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ab858FTsqpKQS3LHMrR2Qe0R0TjRW7W5vkNl7SRbaiU=;
 b=SZij2mow90bMmCXQvoRZXQcJTU0F96T4MFWQV1nEbUowXWj4FLPf588oOTFEN8pwfr
 J7G1cETs6VBeMVckqYtnSNkl9AiEKDf/xtgyZu3wbFgXIx8pswPtiF7lRyRlonvDk2Oq
 Ue//6k72UPDDv2vV3BdaaDAuwRIa3tCNyXjChwbflefAOwSwLUiPXrGcCyOqNbY0WWBT
 sv+HXE3xeReKI/VRd7SKw/HWjf2sNJF2WCe0ucVlJsgSZ34PbYszVv4Jk/WlyRoZoBzA
 NZTM3Jc3H/q10/IranQZAU9mk6Ises5CBknEkPlf+UdGdsTpGqyAA8gcTAzeS5HbYxXI
 XS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783427454; x=1784032254;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ab858FTsqpKQS3LHMrR2Qe0R0TjRW7W5vkNl7SRbaiU=;
 b=YISBIFq2xubRVD/z6kqF3/9p8mWAqwYQClZ2tF0nScv+ahcw6JzVG+d3hQpzt5SSyw
 7lrBsxRXCLRJy1g1qwWCc2xQqEP1o2FzdTqFIN+OASfAwzee4yFac1L7MzV1JT9gl++X
 NrZD5ShR42QZDz9YyVLNj8W4rIHTxYDGk55QSIkU2zgAtmOTtfKMteNlroqqFKio53h8
 SnV5huL3k1p+ZAJYcnICBIgG5dZ9Dg1ozLTY9N+fd1/9IdpegX0KgWJ+NvxveDvQrUhe
 IGATQpZUc4uj8zDEgwslxHL29FRyWr014AZnHiJsczxE7vLlXExxfRBn4rsaFuBDbU1G
 eY2g==
X-Gm-Message-State: AOJu0YzGF3GytVwYIjAhf17aRDCRJ/88tul6SLQG5nxIvBEsVw2y4PaO
 qlOPQYGVmUbBBf1RgZS32p3xUe3EqZu+ucI8sfZ9xCCnF64HrlyKIyMZ+6uzlBntJLYhJDXOpl3
 Vex9FEk5DJ7J2ukIjTDQ/qds/trPVFSs4n4r21xFgcoVgtdJqEM7bnUdneg==
X-Gm-Gg: AfdE7cmZ+1aJXdO1qHGAHwVNviO8copOSDKaKqnSrITLGFPD59/37TY3LB82aK+7eYp
 ACIUZt6ppvQOA0a5ZTjfrgLVOJu5SBNiyQ8a69OSoZcs4xftN3a5lSf/OUg7q9GD/7aN58FOvjs
 MgrCM5khdHmyrEzHJOGAhZfKzHGYfYYKqZgCdO9fttAFuUbyo/3NQdB4NOhOJJqWgdyLKCZlhuc
 E1W1P10/Ok4yKt/bPFCFbI+JIp2HYqLIWGh9el6pbu3e4oJcgDFG6HXTdaz59F9kT3vEBx63iTd
 gCeOoe9SqX5LAng5qLvu/p6iyiGPBuiP/+zylYKi+0ON1zVKXg8nSS2NZjgwt4KKXmCGWPFBCgJ
 hbdfBjxnUnNSZduKVbTm3rcqfkUEbl+14rZBjauk0NRs9l5S4p/Z0pPtUcj64cQ==
X-Received: by 2002:ac8:5f83:0:b0:51c:196:98d6 with SMTP id
 d75a77b69052e-51c748d4a39mr53078151cf.67.1783427451315; 
 Tue, 07 Jul 2026 05:30:51 -0700 (PDT)
X-Received: by 2002:ac8:5f83:0:b0:51c:196:98d6 with SMTP id
 d75a77b69052e-51c748d4a39mr53074891cf.67.1783427447327; 
 Tue, 07 Jul 2026 05:30:47 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d9e701sm5993135a12.21.2026.07.07.05.30.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 05:30:45 -0700 (PDT)
Message-ID: <f0b42f48-2d4b-4f9d-8a3d-3abc1da411f0@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 14:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] hw/arm/fsl-imx8mp: Add inital FlexCAN support
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Paolo Bonzini
 <pbonzini@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20260702184038.178196-1-shentey@gmail.com>
 <519f6e43-5273-4426-b673-71cff44daffa@oss.qualcomm.com>
 <CAFEAcA8aR6GPZWDphbTgPhVf3G=eoNrAFdb9QcLCGh9hdavkAA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA8aR6GPZWDphbTgPhVf3G=eoNrAFdb9QcLCGh9hdavkAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyMCBTYWx0ZWRfXwEWCWqAbJtWm
 +xnr15Om+lKmjAOnDWTcYyTteo+TYv1mp9RKWHWYnATFtPB15tozBH8cJa/+dDR1l1P42X32RVG
 UqXo5gQUFwYMGYxgJk0nhKmKSa9zuUU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyMCBTYWx0ZWRfXxRxhltk7x+MS
 hrbkSr97h1LQ45AdXDmeu2jnvK31L4JR5junep72jq4SivvcTvKAhdYZEEEKpZLTkwjbRTOc0pN
 PH9GYik/deom1HCkJ7pxH4Z+x/04n23uiSR5CN56tjWX4DAcCpECRhOMB4GXQbuvnRv2XixDd+i
 y8BDkTk0JziC6WwVTkYRecVfFi1gfMaDYgJehtp9xGChtfvjpmQbOymO4xzTXsfUnYUfJkWAX6M
 bTV2DFyXRizBxU8/LCaBK4u+ybqa7AJfPHVVGjaY6CUU71tTxnkp/OYkrScn0KfzIpslD9Z1NNY
 HgHEIBGnKcp9H1qcv+WCdYYPs0CNeG5DI3yPnjgTDY46AKHPRt9+Bf2aumty6XB5fM0FfrpSzsN
 FCxq61hatPfmvZZ3QX9zfB9CYNxtuVUvX66DqCuqxnva/ASd/LZ3vyaEelkaCSwDu8uUSzAOdjl
 fk++pCGo3PKlJc1KfxA==
X-Proofpoint-GUID: jAMhEifuPqXJ1tJvP0kgDJteWRI0H8Fz
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4cf17f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=T0SivsIveDCceivP5SkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: jAMhEifuPqXJ1tJvP0kgDJteWRI0H8Fz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070120
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

On 7/7/26 12:43, Peter Maydell wrote:
> On Mon, 6 Jul 2026 at 14:25, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 2/7/26 20:40, Bernhard Beschow wrote:
>>> Now that FlexCAN emulation has landed in master, let's add it to imx8mp-evk as
>>> well. While the real i.MX8M Plus supports CAN FD which isn't emulated yet, the
>>> non-FD mode works well under Linux: It is possible to use `cangen` and `candump`
>>> either way on the host and on the guest, as described in
>>> docs/system/devices/can.rst.
>>>
>>> This series consists of five patches where the first four are preparations.
>>> The last patch integrates FlexCAN into the i.MX8M Plus SoC and EVK board. The
>>> first preparation addresses the review comment from [1], and could be applied
>>> independently.
>>>
>>> It would be nice if this series could make it into 11.1.
>>>
>>> Testing done:
>>> * Start imx8mp-evk and run `cangen can0` there. Observe on the host that
>>> `candump vcan0` prints the traffic.
>>> * `make check`
>>>
>>> v2:
>>> Thanks for the very helpful and super quick review, Phil! Here we go:
>>> * Add patch "hw/net/can/flexcan: Wire clock control module via link property"
>>> * Have separate MemoryRegionOps for 32 and 64 bit
>>>
>>> [1] https://lore.kernel.org/qemu-devel/77d5891c-de12-467e-8746-02fe43121e3e@oss.qualcomm.com/
>>> ---
>>> base-commit: a59157f98f0b69b0bbdb26bc15fbc4d6c8060799
>>>
>>> Bernhard Beschow (5):
>>>     hw/net/can/flexcan: Wire clock control module via link property
>>>     hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
>>>     hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
>>>     hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
>>>     hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP and imx8mp-evk
>>
>> Peter, you just sent your (IIUC) last target-arm PR. I'm about
>> to post my hw-misc one, do you mind if you take this series which
>> is fully reviewed/tested?
> 
> As you note, I've already sent the last target-arm PR for pre-freeze
> yesterday; I'm not going to do another one. So from my POV this
> has just missed the deadline and will have to wait for 11.2.

Err, I meant "do you mind if [I] take" ... :/

