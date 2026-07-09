Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459E2C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmsK-0005Nl-0t; Thu, 09 Jul 2026 07:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whmsF-0005KK-AP
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:24:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whmsD-0002Wn-9y
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:24:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669BNEVn1488701
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 11:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jr7nqG1LMoDZg48VU6EGcRreVnPE+HRizbTPv6opaVg=; b=EXI0SvvbfhqmP+Up
 PK+yKOzd+KVGygMNLgAwV3rJGG+RR/A1i8gezTrBDvVNkTGi6xZG6aN4AHA0vtu3
 TE/keBtbanIB9fMKY0SOXMTO0gNhDKPdnwjeJUK0E19+YdSSq1lP2oXoIuO4akXC
 w0d+3UlOpQ4FjAS5Gps+lvwFs/c4IfpNj/B/O82CXEPh6j4dbFbz8VKStWkz21RM
 46Pc+nFbhWsYQsLIuW713HkonWHaOWTk0kSHO3bFoUHcbvbAxSLLMdY8ojeiVjlo
 8O05dQYGZZfAeKu5rTYtYIjwiF7Li0O4REea9W+r2AF28XujR7uIRJqdla6NVoxS
 Na5ghw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwftw7j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 11:24:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so35781441cf.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 04:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783596294; x=1784201094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jr7nqG1LMoDZg48VU6EGcRreVnPE+HRizbTPv6opaVg=;
 b=eRPMNtGtsg9BpchNBLbDTOZT4iXajfmB0bTGIBLVI49rMlBvN17ENU4NsW1tHusZsO
 Xfwto7whk6OZ+D8A6v1rm9cSL4L7K2eyh2oyYfP3PmK0uCYQDhEII1zPdqKwUUJBb/q0
 /k+0qutgbB6Ky5+4outZmyn6PmWQr4i6SzBXNpYWbPplgDpE9/a9+GXR8f1+rymFnQ0o
 6Eg7IHEy9dGqBsvUx1FsyNXZK2i2+BxUtzmgZfuX95tTsitn5TXwo8viq9O2VMp+X61B
 RGrxYC/gsT8dPtLp1ppYssY/95XhWhn8YiQqEysBynEABuRFr9auuLW/l/4sJirxoZFL
 dx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783596294; x=1784201094;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jr7nqG1LMoDZg48VU6EGcRreVnPE+HRizbTPv6opaVg=;
 b=Ioiy0sqT8FCPx3rl/SurfGBuqA0d4IClNCOaJOqagGYZ4FfoEHoWJoYv5Nqnro7nP3
 YQPygoWySW7kgClw65+UOYLwzQcfVyQnsrjzTlvQCI+TBuK5mmJ2ePWewKWIi7y3GbfL
 QYyQOJt9UJ5VyzTleLo6WNqy9GdDMeCImn0iziYqx+z/V58vjb8lbOpk5cElor4HVBKo
 fpsDQ/CZ9AbkNWhjl2qjTgS406MGaKbh9sY2rvZY0QJLwtJIMLqEZUj/tSgkcStLXsSx
 CSWRKNp/qtALZJ4lZUmKxdkCFUT1Bz2aNb1qgXmMGxuBVkCpiDjknFoRODLK6tctD/TG
 ljhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSu0Z6nQTjhweQbO0B32n7eUCO+I7DcLoVpbESc0lEUc13H+UdBcXySC2lyUnNcssfrFFzvV7zlR5N@nongnu.org
X-Gm-Message-State: AOJu0Yztb8imQtDMcaA9bZWMeRrHA33z20g5Xb41GJ+MRHoZIyrt+zWZ
 ACwxCkkELF+Dv8YMCkQpBntBrjWYcBSbYfIHKbLHESqB6Bq0U6BMUDOFtg9VIL2cqzSjfcyLFxs
 ZTraDTJGKqiFprEumGg0IXtv9+Id4gQmwupKSGYxWncvbqud10UrfXYm/oQ==
X-Gm-Gg: AfdE7clhNWw5Z+xB4Q3+dCEiGGNpkbhCBcHfEBsEpostC1B8SiF04f8Z42/VKhPGmMT
 99j5Xz2Xc3kDGNlQst9c5c1ZyGsRf1+P8U51rwXBem6IqWUDzBmMNHC0P8YVgHWvEtMr0WBAZEZ
 UgDY0KYchfiSaCGpA/sD6Z8tlVDsd3p7tbk0PSh2BOb/w0Q3IJbk46aL7cdWxF7HTrsv/AAQs/u
 ooMZzzt8XvV3m2w3TxHdyU491Bo4DOGAgl6OCwOnVXZ+BGrLLdPPtmNOyqCDWD3sQkJ/LQW4pmM
 mXqhfb1p1QOEHusX4DojCPGrGJskl8FGyXKFETdQ5+yxuN3sVRHjuEHsyQ5SXtylTH15P/qM2RN
 fJoeoUZNWHZad8ozKHd2bqpkkvpKGIn1rnHhmleyJRjWDFMwBZbkbucMN2M6BKA==
X-Received: by 2002:a05:622a:213:b0:516:d83c:edb6 with SMTP id
 d75a77b69052e-51c8b399396mr71210861cf.12.1783596293944; 
 Thu, 09 Jul 2026 04:24:53 -0700 (PDT)
X-Received: by 2002:a05:622a:213:b0:516:d83c:edb6 with SMTP id
 d75a77b69052e-51c8b399396mr71210601cf.12.1783596293566; 
 Thu, 09 Jul 2026 04:24:53 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada05d72sm470529766b.53.2026.07.09.04.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 04:24:52 -0700 (PDT)
Message-ID: <ba3aa0f0-29b8-4c84-bdad-c9d5c0318bfe@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core/machine: fix fdt memory leak
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260709111249.1107640-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260709111249.1107640-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDExMCBTYWx0ZWRfX78pq0O26csuy
 xdQhEnB4gEyzjinFHlUEEQVCBooqB6sUlK2gZMrfjFfxfegx9vD0qJ5yXUsMHHqudzWhFhgBkBK
 VtADijcp+aaT4CwZDfTBxc9YTkCVWsRMSzOy+gcVQjijyY9ghBLiH2zO69RlSf1p/hh4U9di/SN
 eEZPyUGKCPwWHTND3mKX0UyPKtP1L2jka9YC8cpFJ+Pjsfk6VIWK7TbnHT0LikqGtC9G7KJF3Rz
 oQQ0oFk+3s7afHDfg5WkBmTSzD5fMC3l7042mlQvIWNr88rJw158xivopnZWUZC7e3qGaL06jad
 hSPThjtJlYVyarap9nEhWK4XSyqtAXA6X3Nkuu7mLyXetNDAZfskqyrCHhqIsAs1k71L927yNB1
 c5ecbKDwok3W1dq5BjStfiz1RqjmA8q1dNpw0GLypGYxMudtjrUY9c9TZSHOUlvCcLeZo7xrDf8
 gdAOXKEzyKLq413ZDCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDExMCBTYWx0ZWRfXwxK7qkmtnvjp
 Ystr2GDYESNjDy0Aq/N3hggcEu/vqyqtGbuKOwbHSnG4xci+1C10VoUq0qngNLEvhYZ9eAKYC2o
 5FYgHfEVlwpVdyv7dKASpEQxPVsIMdE=
X-Proofpoint-ORIG-GUID: n7lKVr4VsUeBGTM4uOftk4IiofA_NUl0
X-Proofpoint-GUID: n7lKVr4VsUeBGTM4uOftk4IiofA_NUl0
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f8506 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090110
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

On 9/7/26 13:12, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The MachineState fdt field is allocated by various machine types via
> create_device_tree(), load_device_tree(), or similar, but was never
> freed in machine_finalize(). Add the missing g_free() call.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/core/machine.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

