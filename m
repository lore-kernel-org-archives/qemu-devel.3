Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439AA606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b0nFcOUS;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ptm768tS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSwdL-0002fU-2B; Mon, 16 Nov 2026 08:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xSwdC-0002dB-VP
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:20:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xSwdA-0008Ci-35
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794835218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=c0oJdfl5PeD/AefQHBTlui+FiTp8gI4g9os8rLKXKpM=;
 b=b0nFcOUScfRerdrLyqdtZbgrIqynW02GjQr8Tv1fGTzVDzv/WDwD42F2+X5/gCXd+sz4uK
 nTlNW6hJEbhqN20DdfKZM7TfLs8hmqV1DADTcniyfCSpQ60N/QetJHtV0rMyRS7Zd9M0jD
 VodZ5Bj29XNOWu0sSTtD9lHnN4t+oSI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-_Nd20b2AMbqfA-HdqhMj-g-1; Mon, 16 Nov 2026 08:20:17 -0500
X-MC-Unique: _Nd20b2AMbqfA-HdqhMj-g-1
X-Mimecast-MFC-AGG-ID: _Nd20b2AMbqfA-HdqhMj-g_1794835216
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e0461e040so3047606f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 05:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794835216; x=1795440016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c0oJdfl5PeD/AefQHBTlui+FiTp8gI4g9os8rLKXKpM=;
 b=ptm768tSZahz7E88K9kzqGinuCoH3KjIS6bpqODH02UFjLErVvili/6/ojJrCx8ORH
 ckwPlcug6QxqrH8WrlwR/QmRN+hglTQzcFSqLTN2GEt/KEGV8WMmWAjJAlTZNW97f95G
 Gy7VgTNn8kY5fU6hlytWDJ5gT0nGecER5/Yu2z+tkRMoPJCa0b42eGJgEkpihEounOgo
 0vWG9VqVfjHewTxFO0DDLbNoocRVdQeVGYHq5E6vAxiP4ShfJXrpaUY/Uo3heSjLJY2t
 dLEKeXoCOqDpIeVaUgBnY2mkH61FRt3mq372cgUgE438kDrsjqj7NkWfgEFl6N0/oTbl
 VE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835216; x=1795440016;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c0oJdfl5PeD/AefQHBTlui+FiTp8gI4g9os8rLKXKpM=;
 b=b5FFjUfegsm94dssw+TtmNLCdgxLNb8qOp4C7FMuWkedL5X8XQdSsMbGy6mF5y1xc/
 O6mwN5uRMy0D7V/0D78W6yc/6dEt8IYzRUQpPW69D3X4/65kDXYV+21TdHXKQl6tgyXk
 /qsDtbsRVapaA1EbtgQJmOKVFJpxL4Nz0z6xbcw9aUh04b+l1gWhHnZGVeryLrS4jTTq
 1U3gxD7eGqPwa72wc9X8npkmMtXEawjnMZcMGj6N9kC4+pfjGiZoOfRebkPHP2LUOTIY
 vft8PxuEF+iLM5Sk9Oe9kbUUCfthnQ88ibv1aGSoToGNSf6wjbNuNEGmcpitI1310KUa
 peZA==
X-Forwarded-Encrypted: i=1;
 AL+hErGE/Lym/H/kBvZhG/c2wzmzAwDnBCsXO97JhciFCI/X40MWCH1wjnwVwMpccu1x9MaUjOOThar8jPWO@nongnu.org
X-Gm-Message-State: APuU4Z/un2/fNPBACcrlDuMRI7t8gXqB+GvUmoBNwdKC9ggImzFuAHQn
 VZDl0Hd+cALxVNiW5ksxWCpUBY8l0qP1yNHrKRTBxeD7Mky4Dvi2JlITW9DtMNRAgc3t3n5jZb1
 Hhi088KAq/+Mi0oSTyvy6Y0As2AvFAbeIxbES/ihHarGFx9GyAlTF4wxfTeXT367M
X-Gm-Gg: AZFdTZfwhu86vCm7j+CxXJuG0PHpIMdMKyBKUSqv2nGu/bfz+OlV6r1/4oxAQP328pP
 VbG4WOkVGClFNE1vpj7eYMvJJyz56FCU9+qaMFcIlaxfyyyMCnBCMDkySN57UGYtfIOjRB2ZtmF
 q52k+ELQ/o9WNB7BvN5O4qFlwkL0PSI5OPos4pwWHbpZUffkrxDIb4uMe3n6ukZ5tQlxKGH9iAs
 7wyC5x8wm1VUOb/i9UcOOSUymtaaFfPVicxeBEG6ZgTacaJSIcW5aWWy8yXPsDf6DVALUbHhOwU
 S6WdbvvKyBHyVB+Ign56cJpIaDtomS4KvqLJkWwM2WYE4VKqnS5b9UeY8QVqXTncuSq7Gjac0XW
 /ajEZI8fn08TUbl+YA3yfP/6T8Ho83Wrbmoutrp5aroT0
X-Received: by 2002:a05:6000:25ec:b0:493:803e:800f with SMTP id
 ffacd0b85a97d-49c725e5749mr22989660f8f.29.1794835216231; 
 Mon, 16 Nov 2026 05:20:16 -0800 (PST)
X-Received: by 2002:a05:6000:25ec:b0:493:803e:800f with SMTP id
 ffacd0b85a97d-49c725e5749mr22989617f8f.29.1794835215906; 
 Mon, 16 Nov 2026 05:20:15 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c7da37b19sm22697565f8f.5.2026.11.16.05.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 05:20:12 -0800 (PST)
Message-ID: <328228e4-fcc3-424c-8d49-bb4d334cda6a@redhat.com>
Date: Mon, 16 Nov 2026 14:20:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/26] hw/uefi: mark the EFI vars service as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
 <20261113184254.2524253-22-berrange@redhat.com>
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
In-Reply-To: <20261113184254.2524253-22-berrange@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 13.11.26 um 19:42 schrieb Daniel P. Berrangé:
> This is used to persist EFI variables when NVRAM is not available
> or undesirable.
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/uefi/var-service-sysbus.c | 2 ++
>   1 file changed, 2 insertions(+)
Reviewed-by: Thomas Huth <thuth@redhat.com>


