Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC85FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEA2-0001Vt-Kj; Mon, 13 Jul 2026 06:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEA1-0001VZ-6W
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:45:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjE9z-0003JE-Bh
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:45:16 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D77TSk810602
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4r3+okj6ROdiTC4GSPI5YNx5gab0rTplPVka10EUdTY=; b=QJiUlLAebNBDpE41
 TzV1w9vYb3VRKGZs1togOrYPn3tMJP5/d6xjX7S/v4aLV8PGc/Ae/eYfbINEii5L
 vsquoWo7K7hJHRkA03cIgvUWmTMAjswVz8XgN8b4LwvkxSgjMjRUyEOI3viXb2Kt
 bs6icGQIm9gGZs42NMGrV3nkPwO3h87greE7SOHGWGO3Fv18EPGQGy0fy/FHgLSU
 bNvW7UUkumJE6Ko/VwxAtQ6sxqI1FZBacV8aVSkLKcX6rRKbYWNPGX7A5hoKkEmz
 zO5RUE4ssNuniR9JwglOGlBxzEfYBMYhuQpNv3se4Hv4Luu9En3MnrYJiwJUbD1D
 BJdX2A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcubsrsuy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:45:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ec91dc265so240533385a.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 03:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783939513; x=1784544313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4r3+okj6ROdiTC4GSPI5YNx5gab0rTplPVka10EUdTY=;
 b=ZRWQVPZECU6wSU+6y//1+ZZ/JuD3ko49LoQtHjZrQLBEGv/EJgxJ2+AasojDAvLlfi
 z5cclZmBvYqNWqafIocoEgtmryAe+Msr/RyUEsXqW0g4DTH8v182jWZivBG1YrA8VOY9
 8gLtpSwTWXUKMY0fuAdPa+Zv0gqv8s+YAY4J+LNZMVvsVbo4rDu8qKOCFFAEudM8AgZa
 TfdBTqZ3+I7j5mRvstwjKzw+LJsYF+dthUPnqbKcFk5lsY8xydr79Dq32Yhl6SO2cC+x
 n0W2vQmCyo2D6FBP9g35wCd3gmvI7dhQGa+v2irVUL1vFVsFnyPyn2xUkz8qbDkM9teZ
 W+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783939513; x=1784544313;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4r3+okj6ROdiTC4GSPI5YNx5gab0rTplPVka10EUdTY=;
 b=Oyy91XOtzHxFfn9IlsqftzFFWgs84VR4s/DJk50fdMdtuq9coTB4DHzZQERtNmcT8y
 2LdUnhOLdM75qU4YfIC5CfGQSC4/AfqL+ezwuOEQ5qV9jaqb4Pa1jztpycnGODg0LkS5
 Ua+klFCfSfyQgiogVx44VmO08RXfltpolGm2zF059PHSi8eeGUK8RKZznoms9O3zESjw
 lyDX8IPW8OtAcx77YmCxedvTphB4rPFhIDhH9s4xsMkoMas/TVG7bFkFMekfFCy46wWb
 Xjng2ayXGHlagEXuZkpsGeRdjVuUeBd+mWJ+mjfKRNXPRcG9t/9J+XIcTupMA03ttjIx
 CbhQ==
X-Gm-Message-State: AOJu0YxFrrOelMANg+v591JzMDWkNwt1NnfcFRT3kVtd4YV7mwiwQUBX
 OhOhOBvykGw80ETGIG6evMC16D6e8cra4S0f20AtUSbtGnavUleszUYbXjCd8Q/nZCzPXDhOTsS
 OAtnj2JJFeTPzMrMs9HY1S+/a+OSx1hpoZ3jWa2033lX70lhImssPlTqmDw==
X-Gm-Gg: AfdE7cnR8XoewJWwlvi1wbWhv9PSFDBbxKOPBy3xv0763gTcP5I9bpwLcLF/6hHP0WL
 HunNrG1mp/2JZD4UBdyt5a/3h0DZ17bSGhpotGTZGdOnb0+6UXN/nMODOIC/NWYmCsyNB96hPt9
 x+sMk0C6wAoaTh4nOT2a7jhAoXdzK4ThNGl1W960Mczqdp24wjEPNqE95RTORKe2PCruLyk7NJx
 60uKGKw7lKDMXY03OYGRX+QCRr64nz5AwDt4/mhjAqjr0NHBYSio71CrrPiRsaAvS3tHs1Lu6xD
 FQOzXf20/vEkYmm1jjxe1wgSNUVAl1rde2aMHyRf3x52EXxG6t/u0d7bkNvQ1M94+QhOZcyLeDH
 FH8xhiDWhoa7PpmAS325HAW1/qsDHct7IvxtTpfJPM8aXN/AjPf/Ouuq/Ea5NxA==
X-Received: by 2002:a05:622a:993:b0:51b:fe7a:4eb8 with SMTP id
 d75a77b69052e-51cbf0e8c9emr85554721cf.35.1783939512630; 
 Mon, 13 Jul 2026 03:45:12 -0700 (PDT)
X-Received: by 2002:a05:622a:993:b0:51b:fe7a:4eb8 with SMTP id
 d75a77b69052e-51cbf0e8c9emr85554381cf.35.1783939512079; 
 Mon, 13 Jul 2026 03:45:12 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ad21sm84032945f8f.20.2026.07.13.03.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 03:45:11 -0700 (PDT)
Message-ID: <983b8403-4d76-4112-9a28-ff5bcc053c18@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/usb/hcd-xhci: Remove the FIXME macro
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260713100508.123623-1-thuth@redhat.com>
 <20260713100508.123623-3-thuth@redhat.com>
 <CAFEAcA-n-9YVVRr2G3wP0a7sp6arZS4Vmqt35TJY40iGM=DCSQ@mail.gmail.com>
 <f91767d6-c78e-4a2e-b67e-fc74e07a0930@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <f91767d6-c78e-4a2e-b67e-fc74e07a0930@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Oq9/DS/t c=1 sm=1 tr=0 ts=6a54c1b9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=9r4J7D_JezKU99ura1UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: hiHnjTAOxK6p8Xp6qU7clTqxtcZBuHDO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExMSBTYWx0ZWRfX8F406Ia3TzIv
 Uo2uDmQ/H1bWoHmhZOo0IuROg5pFC5nMfdxqGrpdB8GEUeIf9HhKij5gnLRNDs6LbNBzl3lHOnp
 zXTO/LSDWp29KjUqKayha0DAI0tV0X0=
X-Proofpoint-GUID: hiHnjTAOxK6p8Xp6qU7clTqxtcZBuHDO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExMSBTYWx0ZWRfXwq+4J0YmVgF7
 3l1lVwE5sPQjFVzaDKMjuOcJoyd2tCnEf1YQ8HeBGKcH4xGRdtOj2ruH/FjTixMC+ksfyEC+wF1
 ZsYZS5tbvSD/A0+ZXDTezscD7xqhignod69c8X6uhGtxzFB8miRpLSkY1ZhTmPWLyXXKzflWT37
 YnPgW7vrahcS8IyNYOO7iGLHrD8eUcjbJUMeVDpC1+F9gmdJKatNZG59Sfbj6Xde+fxMFcCcDuh
 4rrMnWHlc7AwZewOS72r66cUADWcWK5xvQfG4SdGXKCnSx0FHnD4DGUhQh7ppCOaeiJe50mACrt
 ac2sn+x41jlqynFioCXAyFRgaXU8VBaX5WfopZHZPnlqFSHORAjBnNhDrf+EyvCCKU2OctebCtM
 j49WhxWU9jcJe2Ak5ISSnOf2pxF4OE+oRmyMdyqF4Pjw8iuDU/sQOTuP81o10GSpMzydxvhgFQD
 GA9xVZiAaaohNQUY1ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130111
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

On 13/7/26 12:32, Thomas Huth wrote:
> On 13/07/2026 12.16, Peter Maydell wrote:
>> On Mon, 13 Jul 2026 at 11:05, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> The FIXME macro is only used in one case, which should hopefully
>>> never trigger: The containing function handles all the USB_RET_*
>>> values except for USB_RET_ADD_TO_QUEUE and USB_RET_REMOVE_FROM_QUEUE,
>>> which are both internal return values for when an async packet needs
>>> to be queued or dequeued, and which shouldn't still be the status by
>>> the time we get to this function. Thus let's simplify this spot
>>> and use a g_assert_not_reached() instead.
>>>
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   hw/usb/hcd-xhci.c | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Not sure if some compilers/analyzers would complain about the
>> DPRINTF followed by g_assert_not_reached().
> I hope they don't complain since the macro is disabled by default...? Or 
> shall we play save and remove the DPRINTF here, too?

I'd remove this pointless DPRINTF().

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


