Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615FCCD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 15:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNBry-0005h8-Pd; Wed, 13 May 2026 11:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNBrw-0005gJ-O0
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:51:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNBrv-00028x-9C
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:51:32 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DEsGur4159972
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 15:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rW3O1TwDu8tiKl8Zt+5GU8O6fKO2wCfsAYvwsgiZw7Q=; b=i0UchlRzbZdMHDoT
 rskBDZaHz1d+0Ox8pPqM3CpWzfVIQS+uwRKOHepFem9s9i/SFCLkKHyWjB7hLIiS
 BESeWO2+fRjIJlDcXT4r1AntrPtSuYLwHGpb7mmdIOUYztY+LrCaESckHnMidlNT
 IZ7rgY6FvzmdmX6dvlvfEDyu2wGk2D7aqZ+xAbB9aRSQPa+Zr8mrBCEVUOnZaJf/
 HG2Ex2XD+VtxrYkhBP22dVnVu9gzEuvjHjdbZZRJC9UJHyooZ7lOQx++BG0fKNOc
 xoi2Yt2TY3/xcRnlFBsXpp1KCwVBlqvU4pzYBLXjGDLKnKuKXbs67ur2WlKtjLPe
 aG9fbg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p91smup-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 15:51:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2eebb099efbso11368172eec.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 08:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778687489; x=1779292289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rW3O1TwDu8tiKl8Zt+5GU8O6fKO2wCfsAYvwsgiZw7Q=;
 b=YNilq10MxXOxkxL59ARXPxt5mt9YX14GRa4vLzIgoP6FvpfbEK5I8AyJNXzYqjy1Ii
 ZiwgjYpWGz2E0rTyHYRw+KvmoBlI1BZmzCZHEp1Cw96sNtpNPjVjFjvVlXT4p/0DF/0o
 lZ03JDeWudCcX+OMC3seHIXpp8ONlBymcJI7TWuTTj4Wwr2PmfLmIz87hoU91VSAImdO
 v81otY190Lki4e1lYnedseQ20rontiTRCvXQC4rUid7grhNVM4GJ0B0fkKRGlGg+jZ5A
 CnIQT2fNNNKrRdLnktlyvJguR5WjpM58IkEpW06e9Ke5wTj+rzErrg4O8p4Biqz73Qr1
 c+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778687489; x=1779292289;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rW3O1TwDu8tiKl8Zt+5GU8O6fKO2wCfsAYvwsgiZw7Q=;
 b=sTPPjdXaxzSIkdyVZApTdjQM+tGeSuxdRvALfPLu5htZZwW4XnuhwdIEi+mYKFm7JC
 +XfG2GX5KpX5JP0U+AKXH60MuC6zEGkBY2zCWmkUJOqPO0gzLi0undebdVoRC3or44hP
 Oy2Yvc3gOxpQK94DMDx7umziuVRhzUff6HmhBFCm2fEFDj+SwgXIawL24B5DKMRbwAt8
 ogD6/MotSxi21LseqVBSN8Xuz2XL8dkbnvRnxvWxeGozNQomGPfgxDKY2uxCVPkb9Hmk
 Ev15er5IcJ3IGCWFhI/S8SJLcveTSSP1icR2lBDARn2Wz3uoFkyZMdBfb5peR8+Mh9aU
 Dxwg==
X-Gm-Message-State: AOJu0YzttbCHzyUTrxxHg3LGVxL5JP6N6cVpiCv4DmKzXFMljXPz/erP
 UoNY9DCElAH4MRQROW0ZcAE0xRmzX62DdloeeioQR2IWuq9jvNeGXFiyYNnXwCj1H3G+bRsgPFA
 RLmWaxe2X74xn74XK7EclZspC4TWxygVNRj03jIRxNwhCMp9TORJeerKbww==
X-Gm-Gg: Acq92OH9TIGvMkbe4P1UNOvFuzm3sVCNQj5DayntzCg1QTDhNGN8e2Cxt1S6Kyydolm
 6pCOEaZUJZ7cLU7lsLYku7p69iXiwi5MmMWGYZwzVf90tSYdsrAYjhoxTC62rumjMAyE1C/BkU3
 rki31VmudjsVms0UCucAww4xOz6l2mKZKwWIAVJ2Ssui4ZDtD63BKwpNhp8MfMsPMQ7hMtrpsFY
 34uOHhqIp/do6nGOjAUDs7xm/eHjxi3kpNd8FLLO7azw49MvgQAYYiOT2yZiMMr1Yzp5c1GWFRI
 pWgTneYlG3XSlerwXH0gyUy4RL8NnGC5Pi4XGXh4d/mIQH+dVJYam2Z6CeEbky7gueeDWSla5h/
 nqJJbfO4twgzBgmqEnVjlEcCcp0234Tqcez9Op5mFDsaDYjjWVAFLGkFUDn7yR31+PPfmcAmE+3
 MOhoX5fdvY8iqjsw==
X-Received: by 2002:a05:693c:300c:b0:2ce:3aa1:d39b with SMTP id
 5a478bee46e88-30155943135mr2040326eec.20.1778687488694; 
 Wed, 13 May 2026 08:51:28 -0700 (PDT)
X-Received: by 2002:a05:693c:300c:b0:2ce:3aa1:d39b with SMTP id
 5a478bee46e88-30155943135mr2040309eec.20.1778687488128; 
 Wed, 13 May 2026 08:51:28 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eafc2sm28468589eec.4.2026.05.13.08.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 08:51:27 -0700 (PDT)
Message-ID: <69f6e55a-4743-43a8-a49b-fb7ca6410222@oss.qualcomm.com>
Date: Wed, 13 May 2026 08:51:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] tests: validate dmsetup result in test 128
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-13-berrange@redhat.com>
 <92e4dccd-5f0f-4268-b6d9-6236fa5ed219@oss.qualcomm.com>
 <agROXRPbcxL5mmy-@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <agROXRPbcxL5mmy-@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AhFdiKzsn-DZ_1BvqoIOkcnA6CnaW54z
X-Proofpoint-GUID: AhFdiKzsn-DZ_1BvqoIOkcnA6CnaW54z
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=6a049e01 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=SQPxrGs833apBfTXCeIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2MiBTYWx0ZWRfX724DGLwsqv8N
 PM4QTO/t0jBEGF7hvI/tlYX429RVVG0rVUQZHtABPMXW20WPJFG2NPDqgu0QwHhPT+Yh9rLv/2I
 yu9m5Ihl07tEaqu4OzzTIplCB8p2KsXjkPwAj5RAS7al63pjBj2yvYZkY0lRwri7uqX8CwGWN11
 IravQ711utVITTrnGXj96+ZgPTPLk3a5bngvjEJtWAW4galRCeBfRe1D8HzgiwsJbnEAgIg1gjc
 RTrl6Q+y/nSyaevEmC/q9g3OGxmM9QPIpDcNGyIf0MbXSl3w8Kj9fhcZOdfEoaGhMebgb2ZGfBU
 M2V53yceyfcr1c+x7j5xJtTuFyWMl1xigT+RiFKn34KfuyRyju/VDrdCkMA3cVB1ImEM1q9GQX7
 y9biGSDkxoAvqFcyq7ba9LuACyON3zUJ55UlqDztIxrI5xe/lpi3k1rp07/hN0Fuo+CBFVnuAfe
 xmgOMJb8vTlCCqTFmtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130162
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/13/2026 3:11 AM, Daniel P. Berrangé wrote:
> On Tue, May 12, 2026 at 08:53:47AM -0700, Pierrick Bouvier wrote:
>> On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
>>> The I/O test 128 uses 'dmsetup create' to create a device, optionally
>>> using sudo to elevate privileges.
>>>
>>> This dmsetup command works in GitLab CI, however, the test then fails
>>> with a missing device name:
>>>
>>>   1..1
>>>   # running raw 128
>>>   not ok raw 128
>>>   ----------------------------------- stderr -----------------------------------
>>>   --- /builds/berrange/qemu/tests/qemu-iotests/128.out
>>>   +++ /builds/berrange/qemu/build/scratch/raw-file-128/128.out.bad
>>>   @@ -1,5 +1,5 @@
>>>    QA output created by 128
>>>
>>>    == reading from error device ==
>>>   -read failed: Input/output error
>>>   +qemu-io: can't open device /dev/mapper/eiodev16546: Could not open '/dev/mapper/eiodev16546': No such file or directory
>>>    *** done
>>>
>>>   (test program exited with status code 1)
>>>
>>> It is believed that this is due to the build env using a manually
>>> populated /dev, such that the device mapper node won't ever appear.
>>> It is not a race, since a test adding a sleep did not result in the
>>> device appearing.
>>>
>>
>> Could that be related to the fact it's running inside a container (if it
>> is). Maybe it's just missing exposing all /dev instead of a limited set
>> of devices.
> 
> We don't have any control over what's present in /dev in test environments,
> so we shouldn't assume /dev automatically exposes devices that we can
> create via device mapper, as it could be locked down.
>

Ok.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

