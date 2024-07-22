Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3830BC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVnK5-0006GX-KS; Mon, 22 Jul 2024 03:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVnK3-00067q-EU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVnK1-0001HO-Nn
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721632741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UpBx9Bn6TWBUgKSuqosJxFXuaxTq17dkAIoaCTU7IR4=;
 b=QTtScrAIt4vDAZiwAjQ5iwVwdLEpy8SyK6Ag4FNyKeiPS40Ej2YUvEqUFeka04xow99IG/
 tffMX1U5okQZklQBSaec90uE4QzK7NqrHYQW3q085okXtw5K//VQ5VNiayWlSjHroBSMSu
 N9UbM5z+Rte7Zkzynsex9A6pLwoznzI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-NBh3gwS6O-aL84Oq-W1Mnw-1; Mon, 22 Jul 2024 03:18:55 -0400
X-MC-Unique: NBh3gwS6O-aL84Oq-W1Mnw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3685bbd6dfbso2216250f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 00:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721632734; x=1722237534;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UpBx9Bn6TWBUgKSuqosJxFXuaxTq17dkAIoaCTU7IR4=;
 b=jpoS3pIKfqFyrgL46ow2/CXv4ws9aKdv4ToQa5IeQ15FRE6b2shofFOOlqMdDgEDMM
 MWzHy/+WnMBGTSHy6FxrCnh0s399GAEbRDDWdkEvKV22dXZ7c3bkZiBJkAFVerFxJYXg
 aHKFd65QAMNJzMLAVezLe453EzftGyorPfwN0ticjhBpfSGGQygvI3wygeJ6d4gnP1Zk
 ngPmN4aeEygbh/vNodfOYQLMagSctLEorhDXKbXlNbLBE5UjyllXWPGFgG8b5wA4HZe/
 wPtdSjHddArlB10xgY7mn4g3r0oix53tUvYTGSv4Eg/hw8JoY3IVy878iM7xhRsBaFXx
 Zx1A==
X-Gm-Message-State: AOJu0YwiZ4JuyZF3Xx4vAC2oZWbSL/oCcavV/L41cAkH6+jZuq+Xcozy
 khjpSDhwAvb+rgvDu7z+CzQTfIfBsM2TaYCiOufjf1pR4yxvmztAqzhG75AT2l6r0DzQP1EvRAL
 iWcF4Zo7cNMuilcDpHF2iKYiuyEb0nlXGJXpXCuBw6x/rQhHlZC8ccHxMHQbr
X-Received: by 2002:a05:600c:1912:b0:426:5f09:cf57 with SMTP id
 5b1f17b1804b1-427dc52a2f2mr35798205e9.19.1721632734500; 
 Mon, 22 Jul 2024 00:18:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPhZitXFqQlTmxtdcVeYLhwJjqQ1YKMShe8YTuAoMmdNfpOjn5urKAnR8SDkxj6ABD3bKxuA==
X-Received: by 2002:a05:600c:1912:b0:426:5f09:cf57 with SMTP id
 5b1f17b1804b1-427dc52a2f2mr35798155e9.19.1721632734111; 
 Mon, 22 Jul 2024 00:18:54 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-101.web.vodafone.de.
 [109.43.177.101]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427db2a4e3bsm82639975e9.44.2024.07.22.00.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 00:18:53 -0700 (PDT)
Message-ID: <7757bd81-b74f-4862-b6f5-f9628410d84c@redhat.com>
Date: Mon, 22 Jul 2024 09:18:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/27] iotests/{024, 271}: add testcases for qemu-img rebase
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org
References: <20231031185918.346940-1-kwolf@redhat.com>
 <20231031185918.346940-7-kwolf@redhat.com>
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
In-Reply-To: <20231031185918.346940-7-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 31/10/2023 19.58, Kevin Wolf wrote:
> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> As the previous commit changes the logic of "qemu-img rebase" (it's using
> write alignment now), let's add a couple more test cases which would
> ensure it works correctly.  In particular, the following scenarios:
> 
> 024: add test case for rebase within one backing chain when the overlay
>       cluster size > backings cluster size;
> 271: add test case for rebase images that contain subclusters.  Check
>       that no extra allocations are being made.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> Message-ID: <20230919165804.439110-7-andrey.drobyshev@virtuozzo.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/024     | 60 ++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/024.out | 43 +++++++++++++++++++++++++
>   tests/qemu-iotests/271     | 66 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/271.out | 42 ++++++++++++++++++++++++
>   4 files changed, 211 insertions(+)

  Hi!

Seems like this patch now breaks the iotests when running with -qed :

$ ./check -qed 024
QEMU          -- ".../qemu-build/qemu-system-x86_64" -nodefaults -display 
none -accel qtest
QEMU_IMG      -- ".../qemu-build/qemu-img"
QEMU_IO       -- ".../qemu-build/qemu-io" --cache writeback --aio threads -f qed
QEMU_NBD      -- ".../qemu-build/qemu-nbd"
IMGFMT        -- qed
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 thuth-p1g4 6.9.9-200.fc40.x86_64
TEST_DIR      -- .../qemu-build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/qemu-iotests-b84qth8b
GDB_OPTIONS   --
VALGRIND_QEMU --
PRINT_QEMU_OUTPUT --

024   fail       [09:14:06] [09:14:09]   2.9s                 output 
mismatch (see 
.../qemu-build/tests/qemu-iotests/scratch/qed-file-024/024.out.bad)
--- .../qemu/tests/qemu-iotests/024.out
+++ .../qemu-build/tests/qemu-iotests/scratch/qed-file-024/024.out.bad
@@ -214,7 +214,6 @@
  virtual size: 384 KiB (393216 bytes)
  cluster_size: 131072
  backing file: TEST_DIR/subdir/t.IMGFMT.base_old
-backing file format: IMGFMT

  Fill backing files with data

Failures: 024
Failed 1 of 1 iotests

Could you please have a look at it?

  Thanks,
   Thomas


