Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D329C606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e03jsXD6;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=l0Q10CZc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUQMp-000534-8j; Fri, 20 Nov 2026 10:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xUQMk-00052K-FB
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:17:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xUQMh-0002ya-UZ
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795187834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wTbN3DLoeaQc5y1LNj/HpO8rP9YvFAuIJ+1gNXMtsxg=;
 b=e03jsXD6Q2fcT3Mu2h+mp4doiMGUzZkY/uV9J1RY1Amzv6JIzWkWNWdl4FVN0ZqMjUvdBT
 nfDHcCk7iHAN06tzefRUn+LA7K01Gd7CRxNjNH8A7O2IirsagnPWbURFfJ2Y01WWoDWYOu
 Y3GxKjIzNAks4kLGeJJyxs85OOwZqfU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-Zcv8DSOvNTWu6Wuch6dY1Q-1; Fri, 20 Nov 2026 15:17:10 +0000
X-MC-Unique: Zcv8DSOvNTWu6Wuch6dY1Q-1
X-Mimecast-MFC-AGG-ID: Zcv8DSOvNTWu6Wuch6dY1Q_1795187830
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e0ef019a4so595969f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 07:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795187830; x=1795792630; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wTbN3DLoeaQc5y1LNj/HpO8rP9YvFAuIJ+1gNXMtsxg=;
 b=l0Q10CZc2Na9Dv1DQKRcZnuSCmQSW+umI9fUa5UC/92H5No0Rxic71VuavDtYC2RTD
 cBnlIuYMf54q8HNiFGMzpnDzswx7sZ/l9/WVSEilZTrP8pQ+5XdBNR8Pu0DMPC7DHXUJ
 zd/vHv4zAGJuQgos08gGd1WojIUjI2TxOzHQhw/Zkx1ciXzvWyXgZptGPgjYXvoqiDtl
 T4myJLDFWBFUVCBBcMcZ0wssyr1s7qjlRwVc36tCue6lwwNOi0XciD9XsES8VOXN5vbP
 xglJuYa+Zc92lwc4w1g/FwpEmOr+80HknXuOZk8Pd/WjINPcOiSwdhZjUswap9RtE9dQ
 dwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795187830; x=1795792630;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wTbN3DLoeaQc5y1LNj/HpO8rP9YvFAuIJ+1gNXMtsxg=;
 b=U5yjQN0MIWWvT28r/fJQv64HRi6msamIFGu7v2TnbqqDrm36+vmQ0hvB1E354PMCjb
 eTgPBWK1yjbefuTharTxlXCYnuz7bW1qtxg05o5ugUp1AUO7n6EkdTzK0oHKpo+Oa1b7
 jWIhrYaWLtMQ8oi+wL2zDAH4sOmxsoRxUanH4qzbwJaVNZ2Ht++zpf/Z0372wdklZALT
 rbwECdZMh3Y5VajXfKEECKjTym64Tu6c8j79UBfKbtd7VcZYIqMztQUpV7pD3uR5ijxx
 pZdX36BFVc7Tqk1lLzs+xzwEcIRm6XucIc9rVzu94fFPfwtg7JZjBu3qwBMoClIcimc/
 HHFg==
X-Forwarded-Encrypted: i=1;
 AL+hErHKJuh5rv11p8MAr9EFBgjSrV2YxtlxGXdPwGVTl62+Ii/dE4uy3EjWqcIxiTolyOhpkBvIRarrngsA@nongnu.org
X-Gm-Message-State: APuU4Z+m5aYgFUjTpbNnk92Mh0AEvWwzCgifVpQkElLFofUOEDe3x152
 caK2TSWoCdK7nznPB+yiooGDPT9BSareUCT8N4ot8Ux1YlgP7kjgXIYCJQBxqA9Qx0EhO1CL4e8
 a3cmS6lP4B7fPYFWSiTsiXbVjPcPr/XkMSAeVBXqSMiRN1XF8GogCU9zN
X-Gm-Gg: AZFdTZf0/ZTn0sGlixfrwSQ98Yh5+acIIlx0jq6J2auKDn/Iyub6iuuSVSoflN6sbFK
 M6PDkN2Hm7Z3+vOtf38cl8rHwBOF4FhJKegmQbaEdR/kdWH93mHsvchy+ATM0Q3yC6pozlsvGkT
 6jkOB1DLV/LAa63upYkyPqz1izVbefvT4aK1jbvpHcNdewz4lEv10ACp41FuT66TU9NrZ5pM999
 cOdW34XC2OsfzeLUWXHnhbMMDFPOGilwJnybYfU6lfUNMB/tqlBPZI9MRsQhMFlWWr7dTGS2mVb
 qHhbg0X+FEUPPo7UNDwUvxKvsfv+I5iKEmEYO/oI67fO2HQsDxhm88TtzKo+GEXtDB9JPwDKG2W
 xEVjYemcqNwajJaZJeUZYpuX8Hwe+sWUH5XTyxzvYYJaX
X-Received: by 2002:a05:6000:250e:b0:492:7efe:3fc4 with SMTP id
 ffacd0b85a97d-4abb4b86685mr7272805f8f.21.1795187829788; 
 Fri, 20 Nov 2026 07:17:09 -0800 (PST)
X-Received: by 2002:a05:6000:250e:b0:492:7efe:3fc4 with SMTP id
 ffacd0b85a97d-4abb4b86685mr7272764f8f.21.1795187829411; 
 Fri, 20 Nov 2026 07:17:09 -0800 (PST)
Received: from [192.168.0.9] ([47.65.243.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf62f7sm6613552f8f.13.2026.11.20.07.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 07:17:08 -0800 (PST)
Message-ID: <0699737f-26cd-4edc-a872-fa9e90593d9e@redhat.com>
Date: Fri, 20 Nov 2026 16:17:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] tests/functional: update to newer sunxi kernel
 package
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Eric Farman <farman@linux.ibm.com>
References: <20261120121458.3723625-1-berrange@redhat.com>
 <20261120121458.3723625-2-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
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
In-Reply-To: <20261120121458.3723625-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 20.11.26 um 13:14 schrieb Daniel P. Berrangé:
> The version we currently reference has been deleted from the
> the apt.armbian.com host. 6.6.44 is the next oldest build
> that is available.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/arm/test_bpim2u.py     | 19 ++++++++++---------
>   tests/functional/arm/test_cubieboard.py | 15 ++++++++-------
>   tests/functional/arm/test_orangepi.py   | 19 ++++++++++---------
>   tests/functional/arm/test_replay.py     | 12 ++++++------
>   4 files changed, 34 insertions(+), 31 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


