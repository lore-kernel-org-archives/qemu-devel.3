Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D2FC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJWQD-00023P-Rg; Mon, 26 May 2025 07:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJWQB-00021J-FY
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJWQ8-0005nn-Ve
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748260507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Kgjwt4iSGYzl4DmzKKhriwtTPJ+SFky7WXkUgOVEEl8=;
 b=Gq2aGC2FDbwLSYaSzkyad7CQnjS/wJnDGVWvq8KFpmxjxm9Ht/3RVurJs5LYEkBSuZxZ0F
 iidI7ExTh8EZvQrjXv0futdYih1b1j4c8CbPKNp374IAfIYpSBJ5LBsHoBatCaqUyeS0nc
 3sAHMkHpmnXT0J6B+yTdKoOvTe537OU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-6YFg87kPMtaUAQrF85uLVg-1; Mon, 26 May 2025 07:55:05 -0400
X-MC-Unique: 6YFg87kPMtaUAQrF85uLVg-1
X-Mimecast-MFC-AGG-ID: 6YFg87kPMtaUAQrF85uLVg_1748260504
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4d81f7adeso666600f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 04:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748260504; x=1748865304;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kgjwt4iSGYzl4DmzKKhriwtTPJ+SFky7WXkUgOVEEl8=;
 b=xQsXk2S3zmUZDUMmFtmJETxLiRWf9b1ENTrC6kJFDtPcS5hj6ipLlUm7dULfxRcxi0
 fton0jCWbl8XYxl0tEPHJ0aHWXLt40oYxBUA+IBRF1cMPViXUC4z5uaB06OUpOVevMQU
 9TE+zAVOEQDICVR+pBaMsqpNnkr3gziw+COb015Sp02eFoH5Tnqk9ZIV2V+ypUXe2khv
 eRkSc6Y7Qj/lG/gBny/vQgIoEdeArPtmm4j9yVhtaqT7VUfjYXjxAUxgFwlUESLgj5Ak
 L0iy8UA7y3XW46ONTId04Nv3I2td81zY0/q41t+7wilG4C8nMQcgZ04fBcvAqEKvFK7O
 I4Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGN727MVpzOwn6iXe8Vv8F9vsNrZorKY29ZJtQLCQm5qoaJd+4jIQpvDwW2W5P4JHIQYv033FbT4+v@nongnu.org
X-Gm-Message-State: AOJu0YxM6ObA3Cc+RDhSYLpR7e9NJ2/dI4breTnHM4IrYGV+vPAdVUZs
 DmoHGKtD0eQDGZ6DN0BV6HUtpc0TjytbCl4O5JiiI7Jvk+YYK8tEBMohVFmCEntpHuarPV6WkZQ
 0BXrnVcNwuJnQDelgnMmIvK/rfxd2sBHi7uG3IFA7xyQi9soSB239SyvQ
X-Gm-Gg: ASbGnctpp7s1nN4bRVD+ONoAiSoZJ+ggMZnyv81X1jx8Tyr0u9eTaqEdc/IxWoCPqq9
 N0IN1oG4tr/64ZluRrMQ+k/59bTsErAeln8IkypKwtiVtVKQSYIHkVLU3ntXnnkgxCBSTp2XE/1
 29dWKB5CvO/1QKb2RsnOe7yyVF62YbX7Ei1W16wdcz/aoHXLrUIxFA8kSkAxhZxdEjRRfvvxqGx
 6xcj0XOMX3gxho6rhUkYxzfJ+CYy3uqmBBWORGT/8f1OPSDFE1cK0QzIfYmk61DtF3m4/iCMkj+
 cG+XqKXf75V8PLGV+ArFwmrCC/Y+1GJ40VAG
X-Received: by 2002:a05:6000:2503:b0:3a4:d048:124d with SMTP id
 ffacd0b85a97d-3a4d04812ddmr6186704f8f.26.1748260503868; 
 Mon, 26 May 2025 04:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxULWMU8iwh4mGgWO6eZLC9oAatKM3WdnttM7fQ+xTA7SJJSh1TcWZ2WvnilMccYd7bWcpBA==
X-Received: by 2002:a05:6000:2503:b0:3a4:d048:124d with SMTP id
 ffacd0b85a97d-3a4d04812ddmr6186683f8f.26.1748260503479; 
 Mon, 26 May 2025 04:55:03 -0700 (PDT)
Received: from [10.33.192.219] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d2c0c299sm4933593f8f.28.2025.05.26.04.55.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 04:55:03 -0700 (PDT)
Message-ID: <0e64cd2b-e42a-40f6-bdd3-c2cf303da3b6@redhat.com>
Date: Mon, 26 May 2025 13:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/acpi: Build IPMI stubs when ACPI is disabled
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20250526112346.48744-1-philmd@linaro.org>
 <20250526112346.48744-2-philmd@linaro.org>
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
In-Reply-To: <20250526112346.48744-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/05/2025 13.23, Philippe Mathieu-Daudé wrote:
> When ACPI is disabled, no ACPI code depends on IPMI,
> so we don't need the stubs.
> 
> We need them when IPMI is enabled and ACPI disabled,
> otherwise when using '--without-default-devices' we
> get:
> 
>    Undefined symbols for architecture arm64:
>      "_build_ipmi_dev_aml", referenced from:
>          _isa_ipmi_bt_class_init in hw_ipmi_isa_ipmi_bt.c.o
>    ld: symbol(s) not found for architecture arm64
> 
> Split the source set list to avoid a too long line.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/acpi/meson.build | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index 73f02b96912..76948cdd00d 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -26,12 +26,18 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_false: files('acpi-pci-hotplug-stub.c'
>   acpi_ss.add(when: 'CONFIG_ACPI_VIOT', if_true: files('viot.c'))
>   acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ich9_timer.c'))
>   acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
> -acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files('ipmi-stub.c'))
> +acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'))
>   acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
>   if have_tpm
>     acpi_ss.add(files('tpm.c'))
>   endif
> -system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
> +system_ss.add(when: 'CONFIG_ACPI', if_false: files(
> +  'acpi-stub.c',
> +  'acpi_interface.c',

While you're at it, I think acpi_interface.c is always needed (it's also 
added earlier in this file already when CONFIG_ACPI is enabled), so I think 
this should rather go to a separate "system_ss.add(...)" line?

  Thomas


> +  'aml-build-stub.c',
> +  'ghes-stub.c',
> +  'ipmi-stub.c',
> +))
>   system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
>   system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
>   system_ss.add(files('acpi-qmp-cmds.c'))


