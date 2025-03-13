Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E09C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 07:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscpL-0004lf-68; Thu, 13 Mar 2025 03:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tscpH-0004lP-8j
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tscpE-0001UI-Dk
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741850270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s5mQz7PCryf68y2NikM2rtbrUH9Q0tnp/lnG77DfOPQ=;
 b=FROILf9XWNDiCPGOD2CdnRO6GGFkli1UEOit21aCSXXOBOlctXRNOQMkeUEFiLBhEaz2oG
 13DhglYqkzxZGHWxD8mLuT+sM3mxu1vHJTL6zVFgWMxExjAiwlxClVcftOJOdvjkLm58Xb
 Vhz0N+cptVe6A35NhfaGaUG5prX7zqA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-uaG7v40UMkm2MBrliy2x-Q-1; Thu, 13 Mar 2025 03:17:48 -0400
X-MC-Unique: uaG7v40UMkm2MBrliy2x-Q-1
X-Mimecast-MFC-AGG-ID: uaG7v40UMkm2MBrliy2x-Q_1741850267
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so3896145e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 00:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741850267; x=1742455067;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s5mQz7PCryf68y2NikM2rtbrUH9Q0tnp/lnG77DfOPQ=;
 b=si5cqFQLrPbhH9lWxwfszlPsvsCjnoKiwAwCCzWDUhsL9dzCuJZwYSBBfPIEjOBYZu
 CZEpBtojfp3X4PhagV0FYqZdUcK6UuOw+qIfGD1YufUbsDowaFkzqxM9F94cFavLAwwz
 cgpsWMVtDsi+IuK1rLStR6eHgkZY3oedw0l1+m5Hkdu5jOZQGMcAJMaMjf3pV0UGwAyu
 JIJrcFifY4YfIskx8FFZG+j6zX02koWUs/JCH5LqK61RQUbdCNdIRH2o4A/Mi0vydaq+
 eNuc1SgzClGaBaO2tbuhERMHFyKgi5A1y2OEspf6GpEHmQmC+YWqrfMfSGdvtrRTvBex
 svfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEk9xvatCPe2AHFirO2HZTwUhXZ67JwK1AFYCkD8Be9YRcAxybDCX2cp4a8DmHcoo/DcDCZK54WNa1@nongnu.org
X-Gm-Message-State: AOJu0YzWlBJtNKCU6IBBgmZEF09hmPz6evzUGhwofBL22/17lALobAUE
 zjw2BkypvrOwTS0n60LbyDMfQsV3dJRdHrOljAuYRssM4Yms+wPMXlYlaFe9gPWdOtqTi32CqYk
 6fgkXCpRlk89RtpNr8LP4ayqUQFEVwn1PqRG42ZW/HiVkasOpl8Lx
X-Gm-Gg: ASbGncv/6cQBYNAc+kLbu97Xu8RxiJhrSsu+K1REDYrlcdKFlhs4Ypkxgr7jINYuFjq
 qp3BOpdOCXh2vl/l+2I6glO4kENhUBJscN+NAlFxVFWDL6MOxnvikG5rS33u62no7Yei+U6v7FL
 hf9TsqMr3t9/eF+mowDGRB5eOy9AbLGuMkwwLuSC8wdUZuF+bYhnObv1V+xRlxyTHIeLEEKlxV9
 jBNZ6alOLOUlDCBwPadm92xNeI6EcMGPLgN/+YUf56NMYmpxT8bMnW8IEKVSuRYKPqtPliMznW1
 hFAr6ici3wR2/Y/lqLNwUwONDSPu5kqan7S6FED1X0BkHxU=
X-Received: by 2002:a05:6000:1f88:b0:391:3207:2e75 with SMTP id
 ffacd0b85a97d-392641c02b9mr10503521f8f.18.1741850267295; 
 Thu, 13 Mar 2025 00:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEynSvPiQtztHdvmwyu4xrLOL7rUSH7mmErM9BabbGTe35Z0nkeuEcZX2pYoh6oRTPH+5w1+A==
X-Received: by 2002:a05:6000:1f88:b0:391:3207:2e75 with SMTP id
 ffacd0b85a97d-392641c02b9mr10503505f8f.18.1741850266914; 
 Thu, 13 Mar 2025 00:17:46 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df35f7sm1128394f8f.13.2025.03.13.00.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 00:17:46 -0700 (PDT)
Message-ID: <0dfd507a-290d-4354-aee0-9da031b3449a@redhat.com>
Date: Thu, 13 Mar 2025 08:17:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: skip vulkan test if mssing
 vulkaninfo
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250312190314.1632357-1-alex.bennee@linaro.org>
 <e554655e-7f28-4d45-8faa-3c06b72f74ad@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <e554655e-7f28-4d45-8faa-3c06b72f74ad@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/03/2025 08.13, Thomas Huth wrote:
> 
> Missing "i" in "mssing" in the subject.
> 
> On 12/03/2025 20.03, Alex Bennée wrote:
>> I could have sworn I had this is a previous iteration of the patches
>> but I guess it got lost in a re-base. As we are going to call
>> vulkaninfo to probe for "bad" drivers we need to skip if the binary
>> isn't available.
>>
>> Fixes: 9f7e493d11 (tests/functional: skip vulkan tests with nVidia)
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   tests/functional/test_aarch64_virt_gpu.py | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/ 
>> test_aarch64_virt_gpu.py
>> index f19a47f8b6..314d994a7a 100755
>> --- a/tests/functional/test_aarch64_virt_gpu.py
>> +++ b/tests/functional/test_aarch64_virt_gpu.py
>> @@ -115,6 +115,7 @@ def test_aarch64_virt_with_virgl_blobs_gpu(self):
>>           self._run_virt_weston_test("glmark2-wayland -b:duration=1.0")
>>       @skipIfMissingCommands('zstd')
>> +    @skipIfMissingCommands('vulkaninfo')
>>       def test_aarch64_virt_with_vulkan_gpu(self):
> 
> The check_output call in this function is already wrapped with a try-except 
> statement, isn't that enough already?

Hmm, looks like a missing vulkaninfo is giving some other kind of exception, 
so we need this patch indeed. I'll queue it for my pull request today.

  Thomas


