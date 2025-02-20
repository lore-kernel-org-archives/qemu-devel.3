Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A13DC021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 06:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkze1-0005dG-Ju; Thu, 20 Feb 2025 01:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkze0-0005d6-AG
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 01:02:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkzdy-00025Q-Is
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 01:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740031361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i+YiDensphyPQ5xCR1y/DrKs5Qdg0vsDBaBtToKyXCQ=;
 b=c288ue8veTRYKt8RrD8x2tY673MiPIUeoBXLbmUIYxXL9O3FZqRTpuAs3GPGBH5OtbzaQB
 a4Ra1j6K5mY1JyWNWsEBN1AMl1mZWJ+eAEfwd5vpb8UYBl0bPGc9rp7HDMcr5vUPa4XDaX
 UjLw8QlI2kT2nrakeQiJZ81xnE3NEk4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-gmzHVqhaNxCQQZVpMmyZAA-1; Thu, 20 Feb 2025 01:02:39 -0500
X-MC-Unique: gmzHVqhaNxCQQZVpMmyZAA-1
X-Mimecast-MFC-AGG-ID: gmzHVqhaNxCQQZVpMmyZAA_1740031358
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so3304285e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 22:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740031358; x=1740636158;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i+YiDensphyPQ5xCR1y/DrKs5Qdg0vsDBaBtToKyXCQ=;
 b=qRf5PyLkHGCgjd4GpaBRijhdR/h6UKhx1Ds/vVpF3wRr3+9WAWFmUK7V6UFSoDU87L
 NB17EaD69Zc5Z8xI8WHJWpwnonsn8LiD18BrzEelprXF4taGsY5ZxUeBi4YdrdMmAlsx
 NMMcDfwYhSQul7BZNOTOBty6nt39XPWDRQwH/AYzyNhsFlpbYGehaAoEfB4Pt5HqRvMh
 3Gfee5gD67luDaX0eIdjdnO4gg6Q7pyXx5RLs0YOL4X9bXX4CQVFi+hHO1R1cf4K5QB/
 y9jWVqWmnM4t/Rz5J74SBwQQQ1SY+RjzRQO057n+Bv1njMObqPPGjzkihvdFrVQx6ljD
 uGcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbaN6eIwHmJd7n3usRkcnDpmxi6PzqlqofKm9PmqzaTrsTOZE7NWTM4B0pol2wlg2PeZ03PbvkfQms@nongnu.org
X-Gm-Message-State: AOJu0Yzp7qpGwtZcf7suPQg2p2EIIa62DMvCK15zpp59rL31byHhHak8
 QfqebG6dMK2qk247IUSHsLWDjHUu69ewotRx19D5FnTmR0zgKhO5mjtvFeRwum38zzKclfPKK6n
 2/Fn6074fXxGb/fCVfO4WDkfsBvm1FHd4WIZZsEue2Orr0St9b3/c
X-Gm-Gg: ASbGncu4gw7lx2SEge+gv/vPzKpcl2GulNUlI+WGxePCs/+N3w2nTD5Ba+/OypKnyBp
 Kmwb1BKH6n6I3PTKB3AUYC4nahyhcPsTGE2+mj1kcmrWCfcpdtNnnPqy1icXgu9snaqlMCTRadg
 16bvacvAmIRHKMBDCeSg4TYOBc8fZz4lAPoZTYi68I6qUkkig+KV3njk5Rfxk6dpCMxk++3nMG1
 Do9DK8hznRCnzLUjTtJZDeWw6NFhC1z3beCnoWfLNRhY1ecI0hTyWFjIzbpyOlbxAgM4CIsUxj/
 mGVUtbs9szq2JJar21lA91aCKNRVLHE8bHB2
X-Received: by 2002:a05:600c:4f48:b0:439:8bb1:14b1 with SMTP id
 5b1f17b1804b1-43999d91255mr73394885e9.11.1740031357813; 
 Wed, 19 Feb 2025 22:02:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyCI5FpOC3yOTs2AKzGtepTOAf9Qt+e68R2X9EW9EDozTUn2GAB0IaN2slr4G2S7ouswDAdA==
X-Received: by 2002:a05:600c:4f48:b0:439:8bb1:14b1 with SMTP id
 5b1f17b1804b1-43999d91255mr73394585e9.11.1740031357458; 
 Wed, 19 Feb 2025 22:02:37 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-157.web.vodafone.de.
 [109.42.51.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7f3sm235586765e9.29.2025.02.19.22.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 22:02:37 -0800 (PST)
Message-ID: <0f1eb66a-9fcb-4577-b113-f3dc8c1f909d@redhat.com>
Date: Thu, 20 Feb 2025 07:02:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: Allow running TCG plugins tests on
 non-Linux/BSD hosts
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20250219192340.92240-1-philmd@linaro.org>
 <20250219192340.92240-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
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
In-Reply-To: <20250219192340.92240-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 19/02/2025 20.23, Philippe Mathieu-Daudé wrote:
> Not all platforms use the '.so' suffix for shared libraries,
> which is how plugins are built. Use the recently introduced
> dso_suffix() helper to get the proper host suffix.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2804
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/test_aarch64_tcg_plugins.py | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functional/test_aarch64_tcg_plugins.py
> index 7e8beacc833..306e46c7972 100755
> --- a/tests/functional/test_aarch64_tcg_plugins.py
> +++ b/tests/functional/test_aarch64_tcg_plugins.py
> @@ -16,7 +16,7 @@
>   import re
>   
>   from qemu.machine.machine import VMLaunchFailure
> -from qemu_test import LinuxKernelTest, Asset
> +from qemu_test import LinuxKernelTest, Asset, dso_suffix
>   
>   
>   class PluginKernelBase(LinuxKernelTest):
> @@ -62,6 +62,10 @@ class PluginKernelNormal(PluginKernelBase):
>           ('https://storage.tuxboot.com/20230331/arm64/Image'),
>           'ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7')
>   
> +    def plugin_file(self, plugin_name):
> +        suffix = dso_suffix()
> +        return f'tests/tcg/plugins/{plugin_name}.{suffix}'

Since you're adding support for the .DLL suffix on Windows, too: Maybe 
better to use os.path.join() for Windows that doesn't use the slash as path 
separator?

  Thomas


