Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA45ACD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdfe-00080F-La; Mon, 08 Jun 2026 13:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWdfd-0007zz-LF
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:21:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWdfb-0007xt-Mv
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:21:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658FFVMT3588414
 for <qemu-devel@nongnu.org>; Mon, 8 Jun 2026 17:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 byEZMiyALoWwHrwjcxCgVD5dkZ4TK+9EwlRd5vilHZk=; b=e3/9+CMUmLISOKXe
 1u0fBWHRsjjYKluozrAbYiuiJ7HIJXjZW96GpEk4kj0TJC3Zg9vB9Pc3jIWGyxSP
 aoDkLiIVZsp9uokEnTJidP2zMLsM8geUwLAVNQMqz3aJWo8gT4NWktxkmql7a3aL
 er8hz9yFWUJ81sAO7LIzMX/0oQpiq5Sat4j0eDq0t249wNlphsojWt4VN9q3HSvh
 PNyAJzv49r0AUQiYC8ch7OArqJdcQS2xNFyiLuk+E4JIqLPcWnwdqOf3ITc6fyxM
 43/UMX83/zfCx3+gT08gFDHQy/BSxmnOQt1v8vaexgenx9h7UW59rJqyOuzNgBic
 YfOqmQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun421r4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 17:21:48 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-137e49e896aso2845953c88.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780939308; x=1781544108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=byEZMiyALoWwHrwjcxCgVD5dkZ4TK+9EwlRd5vilHZk=;
 b=UwxlIC4Rx5gsCTqcZFF2gZ1+falBVdwEaAXq5Do++uj/mVS6ioMLlICvcCa0cawHYy
 OyPZ73Dcq10WIXTpa6XNkl4E2s7x2u2Lo4VU2m/hWpiaiaIZ4WgXLI0LO/3b9jbvoK0C
 5ZQoAU5pWGrfBoIciy+d1L4Ld2MYQRFY1nxeOrIHe/2JbcbBjogVthybjfcEPkWtposO
 9d0YC0BrtiYNSxWUmmRSk4c+y/Hl9UipLpULVTlx5Zx0nPzs7iBSUzVlP4YkQJo3rexw
 1D9yG2dLmR8h3kcZb2aCrZHcHrm/Hi0xhghj8tIDQrGe2jcWG+icTjTnW2Zwz5kLSMnI
 E1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780939308; x=1781544108;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=byEZMiyALoWwHrwjcxCgVD5dkZ4TK+9EwlRd5vilHZk=;
 b=tYEALX2pObZxwTY4IbEl65gjVIy90n9+3ZcpweeFNYOC8XtQn+fztpTiUKTdoT8nQq
 A3ooGlNlaOHQLd36rkKwanCPC4Nl1ouqza64vDC6C9n5S1bw+UwIhgq3latcMkz+Uaq9
 iOYn1LoJnhzWm4Dp9zDNOeFT6j6TG11g5OZSRnH+0aKvwM8goOyXgGihhFxZ69Ojtp71
 99K/Mkjo8uUoBcxQpevxbPVcbl4ZNIrN6LtZOzipcDyB5AfW7x67Iihmh5XmwQR/YbFS
 FOwI89zxMmKUm5lG2KB8ZiKvNJOX6JwA9VPh1IVjOzjpoqn5ANo0eGMs57EUmUFcWQ+Q
 NvnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+R5uPkioTFStenGBi2cGG+bnWypuraswP2H9G70P1xXJG0Pyi4y9/RisygENi6hwWrfNBE88VSr49R@nongnu.org
X-Gm-Message-State: AOJu0YxiOwRmLvMmQ0m2RmwyzY8DiybAgXfSVoK/9yYcI046FvvFdBVD
 VuSxcFh1exrP4hlrk7YCcaPJUJNNEJHxCJvmW/+A6tc51gKKLLhuoKD8CQZstkoCx9RbjOEKFSh
 vEHo0I0LrICklDcTMk1wW4+qwpTY3xJwkBtU/2mzbXfdWw5j/rsqTSUPPMQ==
X-Gm-Gg: Acq92OGduKewi0mgEvZLLK9fg0kgzs+IAAnaL9oF4j4kPYJ1t35p7MpDiA15XVRtK12
 C6JfOqjO/CHa1SyZz8vZYF1jaPy9d8utKkrVRUtQTSxEK7aPD2AWZINNmkCGFGnK3jKb6juW48D
 PLTnPPPG9YB//b7qCB+edXSkLq6kEHM1u5LGJPCWNukGIlMftmdIdYEL7bNZf/2D8/BdLvd2HDk
 BdBzUp+9/Q3c5Q/P6Vfj36IXrSTTShyWJe6Q7BRLDbuc1yWFNw8yVc1LTKTrkqkmadXAnC51Bha
 m9fy+mADyCf5lHlxopXmyHguvpP3Sy9BGU2iFExVAJrzlXa/y65XgjXcCW6jqU7lB4R/Gdc8Xj7
 Z48m1bIyrV2QEh2BlQFO29HDgeVMqc2U7rcWkkoTmlXJcIMJD8hIbRrGu/S1AI4fC89++dZbpRC
 V4aIWbWHgtUlQg6bY782NA+eBb
X-Received: by 2002:a05:7022:486:b0:138:5f0:49dc with SMTP id
 a92af1059eb24-13807d98bf9mr7319958c88.20.1780939307914; 
 Mon, 08 Jun 2026 10:21:47 -0700 (PDT)
X-Received: by 2002:a05:7022:486:b0:138:5f0:49dc with SMTP id
 a92af1059eb24-13807d98bf9mr7319935c88.20.1780939307378; 
 Mon, 08 Jun 2026 10:21:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm13243108c88.14.2026.06.08.10.21.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 10:21:46 -0700 (PDT)
Message-ID: <104c42b7-26b9-47de-8ccf-33af3092dd51@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:21:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] net/af-xdp.c: maybe-uninitialized warning with gcov
 build on ubuntu2404
To: Ilya Maximets <i.maximets@ovn.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
 <20260604215148.3769627-2-pierrick.bouvier@oss.qualcomm.com>
 <8cd17fc3-7f75-4da0-a46d-fcd9fb8fba39@ovn.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8cd17fc3-7f75-4da0-a46d-fcd9fb8fba39@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2NCBTYWx0ZWRfX5iia4Ww7xadB
 WEIhqBUYQwI2ZKQSFhXpPmb9itWw15Ij+qZWUdB5QD7zt4lf+n46fAn1PmW49nuBfS6XO/Wtex2
 zpvFzma5FBeWfxH6kErQBJfaNcc48qQxJwOUwAwukf9HUN38X1hznvkd5eq+2eRO2Bs2v9DuPHG
 b8Y/VQWIic/ouhWeDI6zI5SrBl/6JCGfH+Jo8xJRyphXtHm8bGKkcOA7igVBBD2QVm9tox2Q72P
 Mq+HxMLY2nUPpFh53kndjankdYmHdEKLWZJBf7RGgJj9tHizH4fveIAPkPi/nGj/w35Rv3Grj0J
 sT4uojGzlYJkvF2ojU7gGqs5c0QFJzwoA6gsyYFe0XIg+eK1LOgEwlzGDeYh8Wg+7uytAqn+SrM
 i/FfoWg23hY8D6kqoVuNY/fDW4NgX4MkgTvUOe4vL344up9dgyNo3VottKpzDwuCxEt5D24a3PF
 +JfehHmwge8LO2F5b6g==
X-Proofpoint-ORIG-GUID: loP5s_as8bbFBry9ff2EcHSX8lGelDMq
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a26fa2c cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=XJ5qDKgWmhKLeYt-95sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: loP5s_as8bbFBry9ff2EcHSX8lGelDMq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080164
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

On 6/5/2026 12:09 PM, Ilya Maximets wrote:
> On 6/4/26 11:51 PM, Pierrick Bouvier wrote:
>> Seems like a false positive, easily fix by explicitly initializing
>> variable to NULL.
>>
>> In function ‘af_xdp_read_poll’,
>>     inlined from ‘net_init_af_xdp’ at ../net/af-xdp.c:546:5:
>> ../net/af-xdp.c:78:10: error: ‘s’ may be used uninitialized [-Werror=maybe-uninitialized]
>>    78 |     if (s->read_poll != enable) {
>>       |         ~^~~~~~~~~~~
>> ../net/af-xdp.c: In function ‘net_init_af_xdp’:
>> ../net/af-xdp.c:461:17: note: ‘s’ was declared here
>>   461 |     AFXDPState *s;
>>       |
>>
> 
> I guess the 'nc0 && !inhibit' check is what making things confusing.
> I'd suggest to remove the nc0 check and move the upcast out of the
> if statement.  Then maybe collapse the two if statements into one.
> 
> It seems cleaner than just silencing the warning.
> 
> Will that solve the problem?
>

Such patch?

```
diff --git a/net/af-xdp.c b/net/af-xdp.c
index 72d75748c6d..b25c7e69d7e 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -458,7 +458,7 @@ int net_init_af_xdp(const Netdev *netdev,
     g_autofree int *sock_fds = NULL;
     int i, queues;
     Error *err = NULL;
-    AFXDPState *s = NULL;
+    AFXDPState *s;
     bool inhibit;

     ifindex = if_nametoindex(opts->ifname);
@@ -533,8 +533,9 @@ int net_init_af_xdp(const Netdev *netdev,
         }
     }

-    if (nc0 && !inhibit) {
-        s = DO_UPCAST(AFXDPState, nc, nc0);
+    s = DO_UPCAST(AFXDPState, nc, nc0);
+
+    if (!inhibit) {
         if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) ||
!prog_id) {
             error_setg_errno(&err, errno,
                              "no XDP program loaded on '%s', ifindex: %d",
```

It solves the issue indeed, and we are guaranteed it's correct since
queues >= 1. Another thing that work also, and is more concise is:

```
@@ -533,6 +533,8 @@ int net_init_af_xdp(const Netdev *netdev,
         }
     }

+    g_assert(queues > 0);
+
     if (nc0 && !inhibit) {
         s = DO_UPCAST(AFXDPState, nc, nc0);
         if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) ||
!prog_id) {
```

Which version do you prefer?

> Best regards, Ilya Maximets.
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  net/af-xdp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/af-xdp.c b/net/af-xdp.c
>> index 1ffd6363a8c..72d75748c6d 100644
>> --- a/net/af-xdp.c
>> +++ b/net/af-xdp.c
>> @@ -458,7 +458,7 @@ int net_init_af_xdp(const Netdev *netdev,
>>      g_autofree int *sock_fds = NULL;
>>      int i, queues;
>>      Error *err = NULL;
>> -    AFXDPState *s;
>> +    AFXDPState *s = NULL;
>>      bool inhibit;
>>  
>>      ifindex = if_nametoindex(opts->ifname);
> 

Regards,
Pierrick

