Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD24C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgb9-00021Z-Gl; Mon, 24 Jun 2024 06:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLgb6-00021J-6r
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLgb4-0005US-20
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719223608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G522OfGz28qpdWO8TeBeb3IJSGKMR9N+5+X4JHM/oIA=;
 b=fa3yEZbBPDHD69EAzxYE+4WEhN1iFts0L1gnqwGhR3BkRm0UWvEQs+vrWQH8UX5aXUUMnC
 HHbSOU5FwNNsYKl3rF6kfdRFi3G1klFQTXFEZ39qZlsB+h8bx7xuvnoYqVm2B27rMKdUJQ
 uHmj0m0z0jfheD7d4HCiLiptVVyInFk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-LS8bA1j7MC6VK0lxxeWnwA-1; Mon, 24 Jun 2024 06:06:47 -0400
X-MC-Unique: LS8bA1j7MC6VK0lxxeWnwA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36250205842so2598649f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719223606; x=1719828406;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G522OfGz28qpdWO8TeBeb3IJSGKMR9N+5+X4JHM/oIA=;
 b=Ejrb1g066yX6xDvn2aWq+IH7/em46UqHzWVvH8gOVtMW5whfISs69g0xxdPjKiRWnK
 bZ5AH9oX24eFlyV+eYgbzutKf0HC//eJ65oksWhcNQ3DKDB1kgfZJhv2uSTNvmIqMJdS
 efQ2QHU+K/8IjQs/E7zjDp+Ts9nVrVG/FwyMbuvbvGcvZQ4+9SC42sQuyrju538aK7TO
 FYdx7Tx9CGTeKepZijOfs1p5poq9LZosk6SBaCD0mjGHsxdEnM5hX5s65qreZFSHdw/+
 0C6KVfnyFh7eYMgyFuZoAnSKC/w3UE2yJRP7uVklv5yQ9Pxxvv0r3SEmBdacZOC75nqm
 8o1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0rZewgAMhljxJ3jNf+l5arlLZAM2qPqA5miJ7EkV/e0BrYce/MPX4APDAXU1X9ELFKQEC9AvXPWnO8Ds98UwpngTdQYs=
X-Gm-Message-State: AOJu0YyPcdN2QDPrGqzOJnhFp3URzJdrVIUSLNfIA826noUwqwOHEDyT
 xUTKsnqe9ItrdZvNv0c89eWFlEsrXjHWBEW7XI/DCk1hqXEr5LsY0hKUgDvOf9ntcGVSyb/z9XX
 xaElNvaMAHaLeYTOAAjtJ3Bcz79EX7ARb4PCYMd6GTNCgNtQVYrNq
X-Received: by 2002:a5d:60c9:0:b0:362:ff95:5697 with SMTP id
 ffacd0b85a97d-366e32f6e6emr3849800f8f.28.1719223606086; 
 Mon, 24 Jun 2024 03:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExSbu7GlpxIgtlr9r7tyc80qUbn42RZaZJk/lFW5mD2yQYUsQLgazl7AIXtDtygKiiyl8KsA==
X-Received: by 2002:a5d:60c9:0:b0:362:ff95:5697 with SMTP id
 ffacd0b85a97d-366e32f6e6emr3849779f8f.28.1719223605640; 
 Mon, 24 Jun 2024 03:06:45 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-117.web.vodafone.de.
 [109.43.178.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481910fd4sm127994685e9.30.2024.06.24.03.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 03:06:45 -0700 (PDT)
Message-ID: <b625d08e-e65f-4da4-818d-bbc4e2015122@redhat.com>
Date: Mon, 24 Jun 2024 12:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi-disk: Fix crash for VM configured with USB CDROM
 after live migration
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yong.huang@smartx.com
References: <20240610170252.26516-1-pbonzini@redhat.com>
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
In-Reply-To: <20240610170252.26516-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 10/06/2024 19.02, Paolo Bonzini wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> For VMs configured with the USB CDROM device:
> 
> -drive file=/path/to/local/file,id=drive-usb-disk0,media=cdrom,readonly=on...
> -device usb-storage,drive=drive-usb-disk0,id=usb-disk0...
> 
> QEMU process may crash after live migration, to reproduce the issue,
> configure VM (Guest OS ubuntu 20.04 or 21.10) with the following XML:
> 
> <disk type='file' device='cdrom'>
>    <driver name='qemu' type='raw'/>
>    <source file='/path/to/share_fs/cdrom.iso'/>
>    <target dev='sda' bus='usb'/>
>    <readonly/>
>    <address type='usb' bus='0' port='2'/>
> </disk>
> <controller type='usb' index='0' model='piix3-uhci'/>
> 
> Do the live migration repeatedly, crash may happen after live migratoin,
> trace log at the source before live migration is as follows:
> 
> 324808@1711972823.521945:usb_uhci_frame_start nr 319
> 324808@1711972823.521978:usb_uhci_qh_load qh 0x35cb5400
> 324808@1711972823.521989:usb_uhci_qh_load qh 0x35cb5480
> 324808@1711972823.521997:usb_uhci_td_load qh 0x35cb5480, td 0x35cbe000, ctrl 0x0, token 0xffe07f69
> 324808@1711972823.522010:usb_uhci_td_nextqh qh 0x35cb5480, td 0x35cbe000
> 324808@1711972823.522022:usb_uhci_qh_load qh 0x35cb5680
> 324808@1711972823.522030:usb_uhci_td_load qh 0x35cb5680, td 0x75ac5180, ctrl 0x19800000, token 0x3c903e1
> 324808@1711972823.522045:usb_uhci_packet_add token 0x103e1, td 0x75ac5180
> 324808@1711972823.522056:usb_packet_state_change bus 0, port 2, ep 2, packet 0x559f9ba14b00, state undef -> setup
> 324808@1711972823.522079:usb_msd_cmd_submit lun 0, tag 0x472, flags 0x00000080, len 10, data-len 8
> 324808@1711972823.522107:scsi_req_parsed target 0 lun 0 tag 1138 command 74 dir 1 length 8
> 324808@1711972823.522124:scsi_req_parsed_lba target 0 lun 0 tag 1138 command 74 lba 4096
> 324808@1711972823.522139:scsi_req_alloc target 0 lun 0 tag 1138
> 324808@1711972823.522169:scsi_req_continue target 0 lun 0 tag 1138
> 324808@1711972823.522181:scsi_req_data target 0 lun 0 tag 1138 len 8
> 324808@1711972823.522194:usb_packet_state_change bus 0, port 2, ep 2, packet 0x559f9ba14b00, state setup -> complete
> 324808@1711972823.522209:usb_uhci_packet_complete_success token 0x103e1, td 0x75ac5180
> 324808@1711972823.522219:usb_uhci_packet_del token 0x103e1, td 0x75ac5180
> 324808@1711972823.522232:usb_uhci_td_complete qh 0x35cb5680, td 0x75ac5180
> 
> trace log at the destination after live migration is as follows:
> 
> 3286206@1711972823.951646:usb_uhci_frame_start nr 320
> 3286206@1711972823.951663:usb_uhci_qh_load qh 0x35cb5100
> 3286206@1711972823.951671:usb_uhci_qh_load qh 0x35cb5480
> 3286206@1711972823.951680:usb_uhci_td_load qh 0x35cb5480, td 0x35cbe000, ctrl 0x1000000, token 0xffe07f69
> 3286206@1711972823.951693:usb_uhci_td_nextqh qh 0x35cb5480, td 0x35cbe000
> 3286206@1711972823.951702:usb_uhci_qh_load qh 0x35cb5700
> 3286206@1711972823.951709:usb_uhci_td_load qh 0x35cb5700, td 0x75ac5240, ctrl 0x39800000, token 0xe08369
> 3286206@1711972823.951727:usb_uhci_queue_add token 0x8369
> 3286206@1711972823.951735:usb_uhci_packet_add token 0x8369, td 0x75ac5240
> 3286206@1711972823.951746:usb_packet_state_change bus 0, port 2, ep 1, packet 0x56066b2fb5a0, state undef -> setup
> 3286206@1711972823.951766:usb_msd_data_in 8/8 (scsi 8)
> 2024-04-01 12:00:24.665+0000: shutting down, reason=crashed
> 
> The backtrace reveals the following:
> 
> Program terminated with signal SIGSEGV, Segmentation fault.
> 0  __memmove_sse2_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:312
> 312        movq    -8(%rsi,%rdx), %rcx
> [Current thread is 1 (Thread 0x7f0a9025fc00 (LWP 3286206))]
> (gdb) bt
> 0  __memmove_sse2_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:312
> 1  memcpy (__len=8, __src=<optimized out>, __dest=<optimized out>) at /usr/include/bits/string_fortified.h:34
> 2  iov_from_buf_full (iov=<optimized out>, iov_cnt=<optimized out>, offset=<optimized out>, buf=0x0, bytes=bytes@entry=8) at ../util/iov.c:33
> 3  iov_from_buf (bytes=8, buf=<optimized out>, offset=<optimized out>, iov_cnt=<optimized out>, iov=<optimized out>)
>     at /usr/src/debug/qemu-6-6.2.0-75.7.oe1.smartx.git.40.x86_64/include/qemu/iov.h:49
> 4  usb_packet_copy (p=p@entry=0x56066b2fb5a0, ptr=<optimized out>, bytes=bytes@entry=8) at ../hw/usb/core.c:636
> 5  usb_msd_copy_data (s=s@entry=0x56066c62c770, p=p@entry=0x56066b2fb5a0) at ../hw/usb/dev-storage.c:186
> 6  usb_msd_handle_data (dev=0x56066c62c770, p=0x56066b2fb5a0) at ../hw/usb/dev-storage.c:496
> 7  usb_handle_packet (dev=0x56066c62c770, p=p@entry=0x56066b2fb5a0) at ../hw/usb/core.c:455
> 8  uhci_handle_td (s=s@entry=0x56066bd5f210, q=0x56066bb7fbd0, q@entry=0x0, qh_addr=qh_addr@entry=902518530, td=td@entry=0x7fffe6e788f0, td_addr=<optimized out>,
>     int_mask=int_mask@entry=0x7fffe6e788e4) at ../hw/usb/hcd-uhci.c:885
> 9  uhci_process_frame (s=s@entry=0x56066bd5f210) at ../hw/usb/hcd-uhci.c:1061
> 10 uhci_frame_timer (opaque=opaque@entry=0x56066bd5f210) at ../hw/usb/hcd-uhci.c:1159
> 11 timerlist_run_timers (timer_list=0x56066af26bd0) at ../util/qemu-timer.c:642
> 12 qemu_clock_run_timers (type=QEMU_CLOCK_VIRTUAL) at ../util/qemu-timer.c:656
> 13 qemu_clock_run_all_timers () at ../util/qemu-timer.c:738
> 14 main_loop_wait (nonblocking=nonblocking@entry=0) at ../util/main-loop.c:542
> 15 qemu_main_loop () at ../softmmu/runstate.c:739
> 16 main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at ../softmmu/main.c:52
> (gdb) frame 5
> (gdb) p ((SCSIDiskReq *)s->req)->iov
> $1 = {iov_base = 0x0, iov_len = 0}
> (gdb) p/x s->req->tag
> $2 = 0x472
> 
> When designing the USB mass storage device model, QEMU places SCSI disk
> device as the backend of USB mass storage device. In addition, USB mass
> device driver in Guest OS conforms to the "Universal Serial Bus Mass
> Storage Class Bulk-Only Transport" specification in order to simulate
> the transform behavior between a USB controller and a USB mass device.
> The following shows the protocol hierarchy:
> 
>                        +----------------+
>   CDROM driver         |  scsi command  |        CDROM
>                        +----------------+
> 
>                     +-----------------------+
>   USB mass          | USB Mass Storage Class|    USB mass
>   storage driver    | Bulk-Only Transport   |    storage device
>                     +-----------------------+
> 
>                        +----------------+
>   USB Controller       |  USB Protocol  |        USB device
>                        +----------------+
> 
> In the USB protocol layer, between the USB controller and USB device, at
> least two USB packets will be transformed when guest OS send a
> read operation to USB mass storage device:
> 
> 1. The CBW packet, which will be delivered to the USB device's Bulk-Out
> endpoint. In order to simulate a read operation, the USB mass storage
> device parses the CBW and converts it to a SCSI command, which would be
> executed by CDROM(represented as SCSI disk in QEMU internally), and store
> the result data of the SCSI command in a buffer.
> 
> 2. The DATA-IN packet, which will be delivered from the USB device's
> Bulk-In endpoint(fetched directly from the preceding buffer) to the USB
> controller.
> 
> We consider UHCI to be the controller. The two packets mentioned above may
> have been processed by UHCI in two separate frame entries of the Frame List
> , and also described by two different TDs. Unlike the physical environment,
> a virtualized environment requires the QEMU to make sure that the result
> data of CBW is not lost and is delivered to the UHCI controller.
> 
> Currently, these types of SCSI requests are not migrated, so QEMU cannot
> ensure the result data of the IO operation is not lost if there are
> inflight emulated SCSI requests during the live migration.
> 
> Assume for the moment that the USB mass storage device is processing the
> CBW and storing the result data of the read operation to a buffre, live
> migration happens and moves the VM to the destination while not migrating
> the result data of the read operation.
> 
> After migration, when UHCI at the destination issues a DATA-IN request to
> the USB mass storage device, a crash happens because USB mass storage device
> fetches the result data and get nothing.
> 
> The scenario this patch addresses is this one.
> 
> Theoretically, any device that uses the SCSI disk as a back-end would be
> affected by this issue. In this case, it is the USB CDROM.
> 
> To fix it, inflight emulated SCSI request be migrated during live migration,
> similar to the DMA SCSI request.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> Message-ID: <878c8f093f3fc2f584b5c31cb2490d9f6a12131a.1716531409.git.yong.huang@smartx.com>
> [Do not bump migration version, introduce compat property instead. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/core/machine.c   |  1 +
>   hw/scsi/scsi-disk.c | 24 +++++++++++++++++++++++-
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c93d2492443..655d75c21fc 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -36,6 +36,7 @@
>   
>   GlobalProperty hw_compat_9_0[] = {
>       {"arm-cpu", "backcompat-cntfrq", "true" },
> +    {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
>       {"vfio-pci", "skip-vsc-check", "false" },
>   };

  Hi Paolo, hi Hyman,

this patch introduced a problem with device introspection on older machine 
types. Running "make check-qtest SPEED=slow" is now failing for older 
machine types.

Or if you want to reproduce it manually:

  $ ./qemu-system-x86_64 -M pc-q35-8.0 -monitor stdio
  QEMU 9.0.50 monitor - type 'help' for more information
  (qemu) device_add scsi-block,help
  Unexpected error in object_property_find_err() at
  ../../devel/qemu/qom/object.c:1357:
  can't apply global scsi-disk-base.migrate-emulated-scsi-request=false:
  Property 'scsi-block.migrate-emulated-scsi-request' not found
  Aborted (core dumped)

I think the problem is that the property is only added to certain SCSI 
devices via the DEFINE_SCSI_DISK_PROPERTIES macro, but "scsi-block" device 
does not use this macro and thus does not have this property. So when the 
compat code tries to set this property for "scsi-block" (which is also 
derived from "scsi-disk-base"), it fails, of course.

Should the "migrate-emulated-scsi-request" property maybe rather be added to 
the "scsi-disk-base" class instead? Or should hw_compat_9_0 rather list the 
devices that have the property instead of using the parent class? Could you 
please have a look?

  Thanks,
   Thomas


