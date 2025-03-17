Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F958C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 06:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu4Bp-0002Ve-29; Mon, 17 Mar 2025 02:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tu4Bf-0002Oc-Uw
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tu4Be-0008Mw-Gu
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742193777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ckxieCsRVd2gUlaszx6gcEDAe6xqugpI1Ubo06FKUDs=;
 b=LkJJg4jGYehN3SJR6iI1aGNy4RLUdv/RKbKjfdyxDK6/Y3EgiUrfIclM3f9PWqmaBXxTmF
 Y6LcMGb3vwUfIbfyWdGRFcu77tqdO4M/yzv6IjUPBPKPD22vHSD4z9s4fNGJiS5XcqzUM6
 cgwxYTW/9MzRoOHYyWATj/dTyVSlFBE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-8XODwd-wPSavTa4SQiszRQ-1; Mon, 17 Mar 2025 02:42:54 -0400
X-MC-Unique: 8XODwd-wPSavTa4SQiszRQ-1
X-Mimecast-MFC-AGG-ID: 8XODwd-wPSavTa4SQiszRQ_1742193773
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so14716155e9.3
 for <qemu-devel@nongnu.org>; Sun, 16 Mar 2025 23:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742193773; x=1742798573;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ckxieCsRVd2gUlaszx6gcEDAe6xqugpI1Ubo06FKUDs=;
 b=l4n338iJV8HRVJhkbTbwk4NYwkP792QHfB8J+PQjxuw9QgBntdMMSw2uc0btRnXJvS
 vy6t1MYF6ScMdUKyUZR81sjrItC2F3/3HL7U2T8zfQCSmH25Gmmf6VAvNIJfU8FAcQzT
 XoqAPl4C6KHUN2tpVg1alOpTkQhVHsd2NWJVH1SqqNEheXbB9uuGCjJcHTe6uhj0MFh/
 IWJw43JsDGszzSwW12+Jhu6ij3MiPriIyr0k9prhKlkbPhIUF7EDbNdi9dtKEttl21EE
 gO7/dKkeqwQMOzBmVr2LF9MNoRdBGH/hgs3d/xUr9AC+cdYesWHCVIXpf92eWu0eWHTk
 id1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVTE1gBe6LAPGKT6TaWQwKRUuCG9NQKmsVpVu29nNP3MHhRaC/P6M+RIiOzW17t0AayE6WEQzwEBnL@nongnu.org
X-Gm-Message-State: AOJu0YyCdaeSSQrQxkEIalFrShBKQBGWW6OFTZQ1PJ2SxiGM8UJN9eTL
 boSsggldtiMWVpKeTPtZ4B1WFvmgZQurEEhACruVoojFDFwF8FhtdIMn+9wBZh7viSfMpw/4UhQ
 SUXP8d8iAZXjOoGpu3bf5bLHsPNyx1X3w+QelvILDAa5Tv8Nq6H4+nrCqKfAl
X-Gm-Gg: ASbGnctuehcyjkGBfxI/pihuMFt9nBSbqxkWdfYep9hNZC/dH/9F9836iHPK057i63z
 s1hSwVmUZipcIP4MF5janM1NkDFoHjuPZqt15RIrga55pMGUw9H/B7EmwhenM0tjObOQJBVvpFR
 Iw4O/SoCpwj+TLAQwUNLORt8L794A+eLTyLug++xgO+ZUUGXZU2calqutfxcutDDTiUqyAnlDzI
 oB/re3Ba502LnbZGIBlkhJYK2MbEhUFOkEA7hbxE47EOBFawzZ+XqWJSpK4a8lL5WEOrpZSrLqx
 Ow7U4QNdods0PUJGghBlJ5oyFyhINTccn4Thf1vc+YGOQig=
X-Received: by 2002:a05:600c:198e:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-43d1ecd8631mr108179505e9.20.1742193772796; 
 Sun, 16 Mar 2025 23:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSPG5sp5OnDMg2s+oMWz9+cWSpq2Wq1Aq5HBVWdlTm/mITfxQJqrrxWCLi4EYhuhIl6/cd1A==
X-Received: by 2002:a05:600c:198e:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-43d1ecd8631mr108179385e9.20.1742193772520; 
 Sun, 16 Mar 2025 23:42:52 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df35bdsm13648544f8f.5.2025.03.16.23.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Mar 2025 23:42:52 -0700 (PDT)
Message-ID: <9d044a37-bb53-4bd1-9833-3b09823b2e7e@redhat.com>
Date: Mon, 17 Mar 2025 07:42:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] ppc/pnv: Fix system symbols in HOMER structure
 definitions
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
References: <20250317052339.1108322-1-npiggin@gmail.com>
 <20250317052339.1108322-7-npiggin@gmail.com>
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
In-Reply-To: <20250317052339.1108322-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 17/03/2025 06.23, Nicholas Piggin wrote:
> These definitions were taken from skiboot firmware. I naively thought it
> would be nicer to keep the code similar by using the preprocessor, but
> it was pointed out that system headers might still use those symbols and
> cause something unexpected. Also just nicer to keep the QEMU tree clean.
> 
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> Cc: "Stefan Hajnoczi" <stefanha@gmail.com>
> Fixes: 70bc5c2498f46 ("ppc/pnv: Make HOMER memory a RAM region")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/pnv_occ.c | 201 ++++++++++++++++++++++-------------------------
>   1 file changed, 96 insertions(+), 105 deletions(-)

Thanks for cleaning it up!

Reviewed-by: Thomas Huth <thuth@redhat.com>


