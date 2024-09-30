Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27361CE8342
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGEw-0006w8-5c; Mon, 30 Sep 2024 09:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svGEm-0006mY-RV
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 09:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svGEk-0000PB-P1
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 09:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727702090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BOD+9OutAaKoolfoS5fZxVX4Jsf45trbsSArSEZRRLE=;
 b=WLcT9RBf1aTjsnvNI/S/jFK/aJry95BJxZHimZ9vExTKQ2BytfYi/JC6j6aPYEJ8Kko7It
 ZefLYkTvuvD0mAk9cXMWIPLR5HlZtjrCHHrA5sd9h8fLps4sGpTz8w8dSl9jVZSiNGjLzk
 hilnXA6l7PQblMiI7MknYF4peir2wE4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-1NGlHEUyPpiAmr9IBll1fg-1; Mon, 30 Sep 2024 09:14:48 -0400
X-MC-Unique: 1NGlHEUyPpiAmr9IBll1fg-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5e56a096565so2186523eaf.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 06:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727702088; x=1728306888;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BOD+9OutAaKoolfoS5fZxVX4Jsf45trbsSArSEZRRLE=;
 b=gn1wK/UmA1PHDjfFbR9NOgym7Llle/XHiSFYazfdWjXTCaFqOSER/iwaWUvqEQD0UJ
 bwC4GUuM6znnVRNDIZmDiZmYBkCysMPw4aFFwyRl2C61TLUjUWsRbDP2yO21RGixKzn5
 FCDppZSKrvDemT11CK5r+xrsULus27ju5GIhQmMNxueEv4f3l/wtkToMBi3SIQPRgX3S
 LIgnbmlPwx/8vgwF4xv2saaUFDt/ikfaxuuWvpUwmG0ojExun4oLZ8kehy9tAYv7dQO8
 75ur+kxmi5n+RBahkDouuWlCMMJSOu25ua5UeE67AiXICDr1LV4f5BpeweVc014wueX8
 fFgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfvmGvo+07z2aJTo2yqbTwmbyZ1GoNqPCh17Aq+c8XwdzF+fPHBeXslJpfNkdJxfB62gYXahRamtJ0@nongnu.org
X-Gm-Message-State: AOJu0YyUGB2rqH1rPiqMmVaWkvwI6JoCh7UH73ggFTVLpAr7RWDHuc/h
 paouYBpJCTjKIXKp/bTbLDlenN3A918Inaf5HgxBS2No32gCgjiUDY1ATaBE8x0hOvaF7+cLkl8
 Bd2KU6zQbyDG9YKhLSw2xmHM/P/UKq0BYLb+BnlDwaVPOUnusqqm9
X-Received: by 2002:a05:6359:8488:b0:1b7:ed21:a29a with SMTP id
 e5c5f4694b2df-1becbb9705amr249167055d.15.1727702088045; 
 Mon, 30 Sep 2024 06:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBaqS1QYVCdkpzUeWY7PBSp4D8dkNB03CcUicMEUtaZcPsJk5Orku49tBl4MEJwnsix4aUSg==
X-Received: by 2002:a05:6359:8488:b0:1b7:ed21:a29a with SMTP id
 e5c5f4694b2df-1becbb9705amr249163255d.15.1727702087532; 
 Mon, 30 Sep 2024 06:14:47 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae377ebd9fsm405875485a.56.2024.09.30.06.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 06:14:47 -0700 (PDT)
Message-ID: <11deab13-116a-415e-bc44-82fd80dd516a@redhat.com>
Date: Mon, 30 Sep 2024 15:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/18] s390x: Add Full Boot Order Support
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
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
In-Reply-To: <20240927005117.1679506-1-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 27/09/2024 02.50, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Loosely a v2, this updated patch set is a significant rework to most aspects of
> the initially proposed multi-device boot order. Of particular note, the
> original patch set used code jumps to restart the IPL while this version
> does not. In order to remove the code jumps, two significant prerequisite
> changes are required for the pc-bios. Firstly, the netboot code is linked into
> the main s390-ccw.img, which allows for return after a failed netboot, based on
> the patch set from Thomas Huth <thuth@redhat.com>
> (https://lists.gnu.org/archive/html/qemu-devel/2024-06/msg03956.html).
> Secondly, IPL errors that result in an immediate termination are converted
> to instead provide a return value back to the main IPL calling function.
> 
> The routines for building and loading fallback device IPLBs are largely
> unchanged: An IPLB is built for each device with a boot index
> specified (up to 8 devices). The IPLBs location in memory is passed to the guest
> using the global QIPL structure, which is stored at a fixed address. If the
> first device in the boot order successfully IPLs, then the additional IPLBs are
> never used; however, if the first device fails, subsequent IPLBs are retrieved
> from memory and the IPL process restarts using the specifications contained in
> the new IPLB.
> 
> This continues until IPL is successful or there are no IPLBs left to try.
> 
> The per-device loadparm attribute is still uniformly added to CCW devices
> although it may only be assigned a value if the device has a boot index.
> This will need further rework if a more targeted approach is desired.
> 
> Two automated test cases are planned for v3: a minimal test where a guest has
> two boot devices defined and the first fails, and also a limit test where the
> guest has 8 boot devices defined but only the last one can actually IPL.

Thanks, this looks already much better than the "jump back to start" stuff 
in v1 !

One thing I noticed while testing your patches: Booting from ISO images 
seems to be broken for me now, e.g. something like:

./qemu-system-s390x -nographic -accel kvm -m 1G \
  -bios pc-bios/s390-ccw/s390-ccw.img \
  -drive 
if=none,id=d1,file=Fedora-Server-dvd-s390x-38-1.6.iso,format=raw,media=cdrom \
  -device virtio-scsi -device scsi-cd,drive=d1,bootindex=1

used to work fine in the past, but gives me a "Failed to IPL this ISO 
image!" error now.

Does ISO IPL-ing work for you?

  Thomas



