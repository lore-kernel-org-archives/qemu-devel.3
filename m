Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AF7E8784C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 18:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnL5a-0001MZ-6h; Tue, 03 Feb 2026 13:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnL5Y-0001ME-DK
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 13:25:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnL5W-00045R-SD
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 13:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770143120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4VJ5qGLmwlGAWb947iv+WzdmCl1wDHJk64TuQe2Qung=;
 b=ezp6YLV1TGpwiTeZ2MhMeUGUzXRCva3FGukOPyPw2RhlEiq79XqJwy00FiraWLe6UcsKuc
 1fn6GyVDY3TMtu/Mi7M7Dzy87+egaprc8WD9bKae34tfgWeRXJz4VrpgO8uAflVrMEhY69
 uZ6+/EDsTgO1+0EPhKtW5016IVJkN4o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456--YRN7ekyMT2Akevhan1ZJQ-1; Tue, 03 Feb 2026 13:25:18 -0500
X-MC-Unique: -YRN7ekyMT2Akevhan1ZJQ-1
X-Mimecast-MFC-AGG-ID: -YRN7ekyMT2Akevhan1ZJQ_1770143117
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-432db1a9589so4356703f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 10:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770143117; x=1770747917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4VJ5qGLmwlGAWb947iv+WzdmCl1wDHJk64TuQe2Qung=;
 b=acVxe/lrTQqgfcio1EFd5lLRvzFx5KedhcxRq3Fa0CudlWEV89tRcTPTI19vF87dKf
 GXoWh/B6LW6OnVAKzZSrLS3BFlO2oz1hkpohzr20+6OQiYZppohP73XRJo+psQhiMqYC
 bt/Ddqtr+2yHXxdfUXiGzR2DXv9JhcLZWx7zPJCvvT8+exjKoLJt3jwb9Tmo78rqFMsX
 ssEG/Yvu6D9POsDzuEEseCJHFL39XnfACxhYFMh+RzS4x96Tcy9VdAWGC36AqhHsAG+t
 bLAdKH4Nzw+uNcco33lo4BGeWCR+cOmg9tjiQhgfu8P2gN6yfzYqdeQZTvTAHwz13c4h
 yyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770143117; x=1770747917;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VJ5qGLmwlGAWb947iv+WzdmCl1wDHJk64TuQe2Qung=;
 b=rLRtjwC27ERdonTv5GN5kcOvSML9w9stCfqnA8Lr66fyt05mL9nkIq57j9ed7X+jZG
 ongOtKJkntfwI7KYaBwea5akgM+mlZao0vF36zB5gD4jXVHx+wrZtReg57S6VS2LV/Cp
 99f3lxRGIy3EiFe4GHUg+fPpnlRPilzyKLvNxfZNmk1mnFebuZoANSMomfUhsfwqqm15
 we3YC5UdGM714F0sY7xYMDU5R4odNaKOo6YcJ9pDKCnBNMHSJLN/QuYfdUtWiG1Hlagx
 lNzwG7+jGkHqqWeLmYeZvRnzl9BVRo2CnJvxYeS7dv220b0L8YWlfDQwGLLixq03/kIe
 czCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq4MmKG+i41D16Wsx0n3idB2vCxodKdIAtwDpmeY1fmY5sc89QttDk+M5uAbl1hlA6BPvqBbyKFitF@nongnu.org
X-Gm-Message-State: AOJu0Yx3va96BwUsaZtxYcb5olDGplueRLnKB0QxmkbGuK2tt2zATFrU
 +HhNf6IyEdgo5QUonx3WD9Gg5AVoa8RZwuPIUiZswg4cyOWzbweKD8S5TXFJaIQiAw5GJW9pDJn
 2FVEBjgBORk7wWA752W6zGVVq4QR8QtyVxRAhMgWRHKH6CmqxIuWjqEmT
X-Gm-Gg: AZuq6aL5CCp9uVdnf7JkOYt8mEsPgZJgKHyOJsm4EGGGFqjMCw9FN9azqsVVXG5CRE6
 J0gMErQwVCQl62JuMidYG0MAHv8DQC4EKkBO8+PyOk0qhtv/p9yjm47o1VwqIRpKry+D4X05CBs
 e6+2gQ1HYLWTStUZbUw6H1IhKgVZrt7EXzDhW18eAgGvFUJIIVryJnRxOm07L7JdTJMX7xt1TG3
 DU1vUDhc5s1JM8o+WmFFjFOJjEOJGfuKmGNTsCNP9LS4gmkDrR/nMHxUeB6ZYdddAhcWhUYSN0m
 mBLUrviNAbvJpWAutJZwliyR3HWMpFnFmR9TVLOLzsZCPZJ/hCkyNW1fVdV2uZC7FJVOAjleFjP
 7pza7aKg=
X-Received: by 2002:a5d:5d05:0:b0:436:cf5:67c2 with SMTP id
 ffacd0b85a97d-43617e3a314mr459597f8f.11.1770143117480; 
 Tue, 03 Feb 2026 10:25:17 -0800 (PST)
X-Received: by 2002:a5d:5d05:0:b0:436:cf5:67c2 with SMTP id
 ffacd0b85a97d-43617e3a314mr459557f8f.11.1770143117084; 
 Tue, 03 Feb 2026 10:25:17 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805f25dsm463621f8f.29.2026.02.03.10.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 10:25:16 -0800 (PST)
Message-ID: <e3d242f7-a649-4c08-b30f-c2180f3b7055@redhat.com>
Date: Tue, 3 Feb 2026 19:25:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/.../reverse_debugging: Remove unsatisfiable
 condition
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-trivial@nongnu.org
References: <20260203182153.75276-1-yodel.eldar@yodel.dev>
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
In-Reply-To: <20260203182153.75276-1-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03/02/2026 19.21, Yodel Eldar wrote:
> get_qemu_img() already skips the test if qemu-img is not found and does
> not return None. Eliminate the check for None on its result, and the
> unreachable skipTest() gated by it.
> 
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
>   tests/functional/reverse_debugging.py | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
> index 8e6f0b0e92..eaf178da49 100644
> --- a/tests/functional/reverse_debugging.py
> +++ b/tests/functional/reverse_debugging.py
> @@ -73,9 +73,6 @@ def reverse_debugging(self, gdb_arch, shift=7, args=None, big_endian=False):
>           self.log.info('creating qcow2 image for VM snapshots')
>           image_path = os.path.join(self.workdir, 'disk.qcow2')
>           qemu_img = get_qemu_img(self)
> -        if qemu_img is None:
> -            self.skipTest('Could not find "qemu-img", which is required to '
> -                          'create the temporary qcow2 image')
>           out = check_output([qemu_img, 'create', '-f', 'qcow2', image_path, '128M'],
>                              encoding='utf8')
>           self.log.info("qemu-img: %s" % out)

Reviewed-by: Thomas Huth <thuth@redhat.com>


