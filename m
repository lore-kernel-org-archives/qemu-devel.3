Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A94CC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 20:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn1aQ-0001nj-SN; Tue, 25 Feb 2025 15:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tn1aO-0001nG-JW
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:31:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tn1aM-0001KA-HH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740515481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PNWoHXjRjWt3cHg8VqZRfmUuxjgqlDm0SNmDBAv6VxY=;
 b=Vsx0gZzHjsJ/24pE/1uSlcpp7NLPKMPdHrdCRsMgGnMd3BmiZr6wjGqNq8e0jdO41H/LKX
 69WKmu3uzE1yhH//YH3PGgdMwnupP8ya9C6baXJc+7iFSI7xTenhUhnYL7PVMje1aBDWl9
 C2ERixKzjeWdcV+QPEz7pzjRdQXRmtM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-TPbwLiuuNjO_2u6K2jbLdg-1; Tue, 25 Feb 2025 15:31:18 -0500
X-MC-Unique: TPbwLiuuNjO_2u6K2jbLdg-1
X-Mimecast-MFC-AGG-ID: TPbwLiuuNjO_2u6K2jbLdg_1740515477
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f2726c0faso6305158f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 12:31:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740515477; x=1741120277;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PNWoHXjRjWt3cHg8VqZRfmUuxjgqlDm0SNmDBAv6VxY=;
 b=IqbQ+BXyZoALYcOA8N+7EQUsNBqhYcNvICGcHDRzDOrcKd3/7ahuPi4ZEFpf8b4SDt
 10wejFRUq6rORUEAihG7TeKTnWr7CvlHgpK9oZeNtxbY4vxSEi71Rk7aDpxe+kmanH7n
 U5EQVrIFfRw3a8TqY5XBFJ7VPge0KVJp6HFM2cq+2xzU5ayWJ//S6UUmi6RNkpxWSCuG
 JI4nvho9HJea5scx6fS7ARCU0zGieHqjsps0UQLu8eGxh0z+5eSvCfgTgsw1y+FEnRHU
 q205uORCJwc/O0eCT8IeAfmegVuJM2tXhTQZvJLFaGr3aCxxjZ8pZwvHoh18mfidmnYT
 zyfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8+CDdJeWH0iDe/ov59XYSJMI0QgFVEMGmiqxSylJvmTs2uHiVamY4CoutqB0EFDEcxrVBLLFdCTTt@nongnu.org
X-Gm-Message-State: AOJu0YzhS7qAl7esIRuyFz+j3B4KUSt99HXVO4G6yhHxw/hOcnH8V7vY
 ChNf/m3lrbnw1WSQ6hRUPW0BVhGd1bmDxrpvBCLSACVUpvHTicFueXHE1atW5tKndCmSzn0DIIL
 FayOqopaP0LLu5qQ7xbG3KvxUX7AH4nu3S2YN35SpPM/UJ3Zse+UR
X-Gm-Gg: ASbGnctG/v1iHrWHzpZb/orly955pyDWOh6uwcH9UNx0wXZsD8ABkT9tCwpbYZyegiy
 gZXM5mmMSWMQZk5XYfXlfTBFrb4n3YidQINzJDCy7QXozSAf10dy7F665AVPnvHXs4aV9EW4jqH
 M2JJcRv3YE42ErH0xGahqlvC/QfvcnwH9mty93v8sWibeUOLOen08ggY0tJAx3vbcdDriHWj6z7
 NqOT5awku1gdNj93wkfaWQJC6Ctr9BJ54/cdRLLAAB0lpx0M2aAJ5wjkOephW1Wlt3mEj6rGZw8
 Amc4kFIV2Hk2Z90Ty1Ls8MezYIDrxUxEJjucJG00kIVyMrw=
X-Received: by 2002:a05:6000:1549:b0:38d:df29:e14f with SMTP id
 ffacd0b85a97d-390cc631b46mr5122092f8f.43.1740515477068; 
 Tue, 25 Feb 2025 12:31:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0dFnmZu9aclT5r1nRl0XDKIO/v9GAJ2zjbY+4uKYcwyOLJa86RjufdbCc5WGMwFQvPpUcRw==
X-Received: by 2002:a05:6000:1549:b0:38d:df29:e14f with SMTP id
 ffacd0b85a97d-390cc631b46mr5122076f8f.43.1740515476751; 
 Tue, 25 Feb 2025 12:31:16 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fbcabsm3358078f8f.86.2025.02.25.12.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 12:31:15 -0800 (PST)
Message-ID: <9f3daa57-6ba4-483b-be6f-b19bde52cb12@redhat.com>
Date: Tue, 25 Feb 2025 21:31:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests: Stop NBD server in test 162 before starting the
 next one
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250225070650.387638-1-thuth@redhat.com>
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
In-Reply-To: <20250225070650.387638-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

On 25/02/2025 08.06, Thomas Huth wrote:
> Test 162 recently started failing for me for no obvious reasons (I
> did not spot any suspicious commits in this area), but looking in
> the 162.out.bad log file, there was a suspicious message at the end:
> 
>   qemu-nbd: Cannot lock pid file: Resource temporarily unavailable
> 
> And indeed, the test starts the NBD server two times, without stopping
> the first server before running the second one, so the second one can
> indeed fail to lock the PID file. Thus let's make sure to stop the
> first server before the test continues with the second one. With this
> change, the test works fine for me again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qemu-iotests/162 | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
> index 94dae60d304..956c2c5f339 100755
> --- a/tests/qemu-iotests/162
> +++ b/tests/qemu-iotests/162
> @@ -65,6 +65,7 @@ done
>   
>   $QEMU_IMG info "json:{'driver': 'nbd', 'host': 'localhost', 'port': $port}" \
>       | grep '^image' | sed -e "s/$port/PORT/"
> +_stop_nbd_server
>   
>   # This is a test for NBD's bdrv_refresh_filename() implementation: It expects
>   # either host or path to be set, but it must not assume that they are set to

By the way, this problem also seems to be caused by running configure with 
--enable-trace-backends=simple ... but I think stopping the previous server 
before running the next one is still a good idea.

  Thomas


