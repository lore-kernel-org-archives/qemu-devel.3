Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AEAC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x67GA-0002AN-OA; Mon, 14 Sep 2026 10:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x67En-0001xj-OO
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:00:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x67El-00036D-PY
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:00:49 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0Po2674411
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yJuW9qagNokRPYBHsOeWJisj9iYTxnVeVMKk4TTIhpI=; b=GzgADTGtQajVy826
 NDQ2dUgUxlgVR7pycJQy113bU1P05KDbU1ha3xbu/4183zrFMheBPtcU1glV8ZRu
 +tvkBqseywd96uCHksc8HB/vJcPdTuMjt04cdtUGoHgGcCUVsDE0b/3rYpFYAPWn
 ZPZV5RI9dTIPT2kLahqB4T0SNoS24X++ICjLa0CB8avYIxZOzIV6/+nk2OEto36j
 QW/5pwgblmTDLiT1iEyQAEGOl3Po2m6zpflRK5rSF95IL2V6990rZwP07ZXKA+r1
 or9wfxC6f+cofBjpI/rslA1OmfSU+elOvLKNKY50AWrR9/YBWfBw3xie96L+bdcA
 sDDmqQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpecs9121-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:00:43 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7961a79fcd8so341685137.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789394443; x=1789999243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yJuW9qagNokRPYBHsOeWJisj9iYTxnVeVMKk4TTIhpI=;
 b=EVReOwoY/N9++bApy+RNbEnmWTLD5GAmCoihFSReynOBR9mtBs8nd2A3/VuNXshd7j
 SXx0qPsBWJZGuyHvr6skKJT+47Rv8XGxUY9sDEbnqMMZONZYfmUI01u0YPmpkJjtzCFQ
 fAP8VQOLiKrY4mA8xIaPo6Bi1C6J/502z92FTuaVCzdztGV/FFVZSrNYCsDs1C7bu40O
 qtL8NEbCcqPjAfB4I/hdkqmt2l2JQbDjq8Ec77GqVJkVX2YSeLngt4lnSrnh1EIDwYec
 H1viv3g/FfdSb29glQ2BbejKh5Nurr0vzcn4IU6XA5p6EnbVDPizJhpIITKF145NQg4T
 jLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789394443; x=1789999243;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yJuW9qagNokRPYBHsOeWJisj9iYTxnVeVMKk4TTIhpI=;
 b=WpZOP2h4O1GztwAeyC+9EP0ltJUG4C+wimAgSe+hn9d+EgRF3U7FewiyaHEBPjp1iH
 Hw+sLZWPdK2huYipP5ENJPn7Xx4k2k8xQUAJQQnmWWJfHS+15ANksDDO4875jgEvPGbp
 MyUCKzNH6LoKQqfvtHivMWti8oQIeJ89Hcwg9Wn7yVWxT3BZWGPbAL/QJU6Ki3pMgzWy
 klH5rhd8G7K6dkdraewQMgx57rPzUw58rAaAzdEeFhrWrMyy6CYcQL5CHlq2BsuzXwNw
 o8FdNKASFpNDvpXXvfrLQDFbmRhtqc+WqbmruFOEU9WlwoSnFQv2nLWHSU/msQDzzg06
 8g7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxeSjUjIDAQ7BWwLGKcJBxBRpcvCysy3woji4J4BTz/vEnMNw9q4NGP8Mt+TS0RgqvNHB9IZGfV/LNt@nongnu.org
X-Gm-Message-State: AFuF++mJo063OgsfV0/ukL+JqbKJpAgv2sqbWpa/COEVsWHdzt4jrbmH
 C/WsZRsIyt0EWIJo79c5wKILpULc2PEkLKu7X/M5e4locxW8uyV8c0xOxHgetJVdwd6614YAldj
 1fVgc93WabP/nawAQKnTBjwEvsUtHb7+Lnzm8xVU9WPIhDo+uM45JjInHtw==
X-Gm-Gg: AYBFou3IQaOZF5wCjejM5W7vttzdvgmM6DHF/QTYgcw15QeTvMhAaIENHcAO48wVP2w
 qryeZnUjmQjBI9MA1QZQmnm1HbbjkzSBkSrCdbBLnCUmQQKXUC5ZldvYY9Ug3J8NdPJueZidbId
 UVs3Bj+eYGJTgi2KFZBi7JQxCMBHYnUnWvSZKoX3AxV1RuNmMVFhr7dz03XYlF9qKSlHzunp3mK
 ybs/mugZbVkfb57bP1XTZktbXRbbFbNIGw9jItPDe3Wnh6zNjqGw9X+NsDvLz6GWQQBSV4Tf33+
 HKhO5yj84KA8qmczwRK5upENL0k1dwsjastPuQUWti0/ltQ71bsnty+BJg0u2G3FXZGnrIREru4
 CT3qCfgLd7XoNEJVZZDRigIwbKEt7f2w5KJ+AM+KLonIwlMc6oD0HUz4uV6W10f3x
X-Received: by 2002:a67:e09a:0:b0:79b:afc1:21f1 with SMTP id
 ada2fe7eead31-79bafc12fe0mr1159974137.5.1789394442278; 
 Mon, 14 Sep 2026 07:00:42 -0700 (PDT)
X-Received: by 2002:a67:e09a:0:b0:79b:afc1:21f1 with SMTP id
 ada2fe7eead31-79bafc12fe0mr1159132137.5.1789394438193; 
 Mon, 14 Sep 2026 07:00:38 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f4d0700sm97245636d6.38.2026.09.14.07.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 07:00:37 -0700 (PDT)
Message-ID: <8420b6cf-4367-4388-b1f0-4dae7d853f33@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 09:00:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display: Guard new_blob to fix Wunused-function
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 marcandre.lureau@redhat.com
References: <20260911141906.736052-1-brian.cain@oss.qualcomm.com>
 <48eacf0c-503e-497c-b54e-686607f9cbf7@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <48eacf0c-503e-497c-b54e-686607f9cbf7@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwMCBTYWx0ZWRfX/2Tf9vSra0tX
 YzPi2O7l0ihzMdkTag2DQNgab5EyDWfr4s06BUEDJxpp0VH7AAVGF73dSHvVqZLHBqbU4oj7/G/
 sMB4xAcnyqrY0bXKJMF2OsUCN+O1scs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwMCBTYWx0ZWRfX+dZpaHM52asr
 PUCKST/zJgwjmYxcgrafvIxjjo37jYyK3MuKrzb3WrCGTONiM+Bztvz0yrgNu8ygyodIoqwiU4f
 CnphCqxalRMjRUj2otAgmiBXsQXM4/8UsX2uK6RGc/YnCmHSOCn0xRn5DfFoTeR1rnraJKAZ/kK
 6fcJ0WLshbzhF1/8KNYGiYPd8mNXbZajun+pKXaE44I200kQN7k0oKqBzmMM239ImCn+tHA0n2S
 uzIqlSDPAJw3vNCh9JMQQIv0nAP2SRwqDwzsZO7oe9XCgFXEGXHzxso+Jgl2+vAlYh/RiAB2wC6
 XwcEY5r9NX44HuHuWfw+VvukpSOqyrbQVhbzIjM8TYHEQ07BT0gGkBg/ZhY4tnYWJcz+gVW1zWQ
 PGK0ImUvLn29tUHEphbBxqEX8vIlMnMXxZuvWOLnMSAun90hv2qQVxF3c8zn6ObMBXoJmizdcfP
 AyN1KNmU1FIqneYPSRQ==
X-Proofpoint-GUID: 3Y4bk7-hzXPLuJfOmHaEin_HYv7HzTuJ
X-Authority-Analysis: v=2.4 cv=b/cncdGx c=1 sm=1 tr=0 ts=6aa7fe0b cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Tae_BuFR3kxi_ssq9qgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: 3Y4bk7-hzXPLuJfOmHaEin_HYv7HzTuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140200
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 9/11/2026 11:46 AM, Akihiko Odaki wrote:
> On 2026/09/11 23:19, Brian Cain wrote:
>> The call to virtio_gpu_virgl_resource_new_blob() should be guarded like
>
> s/call to/definition of/

yeah - I was going to send a v2 when I noticed this but realized that 
Marc-Andre had sent their fix prior to mine.  So I figured this one was 
obsolete.


>
>> the (sole) caller is, to avoid -Wunused-function.
>>
>>          ../hw/display/virtio-gpu-virgl.c:328:1: error: 
>> ‘virtio_gpu_virgl_resource_new_blob’ defined but not used 
>> [-Werror=unused-function]
>>        328 | virtio_gpu_virgl_resource_new_blob(uint32_t resource_id, 
>> uint64_t blob_size)
>>            | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>
> May also have:
>
> Fixes: d814b44636d0 ("hw/display/virtio-gpu: introduce 
> virtio_gpu_{simple,virgl}_resource_new()")
>
> Nevertheless, everything other than these nits looks good, so:
>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
> Regards,
> Akihiko Odaki
>
>> ---
>>   hw/display/virtio-gpu-virgl.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c 
>> b/hw/display/virtio-gpu-virgl.c
>> index 1c9380e2a6d..f45571060fe 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -324,6 +324,7 @@ virtio_gpu_virgl_resource_new(uint32_t 
>> resource_id, uint32_t width,
>>       return res;
>>   }
>>   +#if VIRGL_VERSION_MAJOR >= 1
>>   static struct virtio_gpu_virgl_resource *
>>   virtio_gpu_virgl_resource_new_blob(uint32_t resource_id, uint64_t 
>> blob_size)
>>   {
>> @@ -335,6 +336,7 @@ virtio_gpu_virgl_resource_new_blob(uint32_t 
>> resource_id, uint64_t blob_size)
>>         return res;
>>   }
>> +#endif
>>     static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>>                                            struct 
>> virtio_gpu_ctrl_command *cmd)
>

