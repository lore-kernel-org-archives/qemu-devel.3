Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2760A2607
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rA4trIYj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU7Mo-0007qA-BT; Thu, 19 Nov 2026 14:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1xU7Ml-0007pQ-PE
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 14:00:15 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1xU7Mi-0001Yh-90
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 14:00:15 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-703be215729so35367eaf.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795114808; x=1795719608;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yKtrPYySzVpg8srBQPpNto74Mks9LdrvipSbyL58qpI=;
 b=rA4trIYjtWk3RSQ8G+peczusKaCBUD53d5winxpce2SKQljgCFddM4SFvnd+7Zm1/I
 3ZM0hoOfvONYbGlcfvC9eWwd76IqHIMLPS6Zsfe645Knphgvm7vpggrluw6g8DoJjJ6g
 v+T3U+8FT5zYSHO6ZJpn7+ZPBCZXdMJzdyOuRDGEmQZkw8XDJi+O9o96swwWJrIOqg3J
 n8JtA+yQ4A52T7jA9T4IG27ZTNn1HNUEPV4a/P0UM4MYHFhXeD8Bd8ZWlwBQljPUrAhw
 S02bRskJTrvdVfFD8yxRlv1caPOIo9tee8pcY/vMTfmHQb/bAJmhcyuoiabPzNYc+Nnq
 wDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795114808; x=1795719608;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yKtrPYySzVpg8srBQPpNto74Mks9LdrvipSbyL58qpI=;
 b=LuJs1ZLU2G6/1pAYGIWEg0wBRxuPKQ2CbBLYsZPWac9+JYgw9hkNRZBvIR7JosKL6X
 HfsA8BQxIVXs32YDOFfLWeoE4nhzkKAG17ywnUfpdhaXpbS4+lTs0ih2tkvWOCZBJ2M+
 26chclO5oEz1AygS+XO2OHvR+a2ekKaEFlRQt2UhggT0WUOMNxZsyGXzsMK11wSj8+Dc
 ytvFEScb/r9wVHu+y2Ooq5cVueSanQK+BdbuAChOyjCD181cAOHLLNBs+Zqdx+2AZ+q7
 nNm8+mi5Xoo2skkuHomtjTLvvfcl/1QT/REc2HtAv6szEN2tI4c1hwE/1KQBNtReQmOm
 xN6w==
X-Forwarded-Encrypted: i=1;
 AL+hErEWiw0Zlcq//yZDPBFc4hC/GdzY8eRStMjUaisZBzZFvIg2FO965uiDzgjjMH0/WlaSzJJLeirDmtus@nongnu.org
X-Gm-Message-State: APuU4Z9J/PP2PmVXQ4yxBMSoeuYV9j/Fe57Y0vLqqWJCzontp3NiXjYJ
 erYHX+G0CyVxjF52mZkRJE2mzb82RzC2WZtsXqn+l6rWkx51wV4ixkCprzWDVwIR9a0=
X-Gm-Gg: AYBFou0Q2P/uEUrutJghY8M3DchIzbFMDffvHZuzvXzCqOl5Z9KNwocM4zuGmyCxBYd
 /I9EPoh3MllKMBZqiF6+zwWptBlEoZUwAWBmJE0i/aBuRua2nJ7tXnRoI24/vnV4FPffu5rjY72
 82gXas4pvLFWacprsBslY27/fY9mcfoLjXFbgfHbEV4nhKuh12OIaQfz/LIN1rZxV70SUMKNfg8
 T2KQD5FXDBkRUhuAnAwsKBmkB8lfuEdZWiNaKGS+1bofDZQYZ+66SSnXAv7tffJvE8lELelt1S9
 eDNcoPGYY9RazLknxlRE+1BPyDX8xh13Jw5CT4rLDy/X/+yxM7ciB+iC/4S1mae7XGBVBDHp9Vo
 ubaeScppzUAep19ZS9ZxctU3bYGP+VP+y6C0jka5WQQycFEB4JRpbl0GHG+r3K055Kmav/svEFI
 wo1YvA/b/dx7tzAKVkOrPkjGcYOnkBwLhLIEjzAGo6Ia9c2cIj2pPgz4pPiS2xdQ5Qe97iK4MwL
 uKBC4WyGfRsZf9or2Dr1kT/nbDcWn79FNIVTz5t87XL3jBKKfZMABmzSWgHo2sSQUuMPa30aPnj
 tbwewmQ92YJZso2b+uRGdrJWtcNlFldef1fiz/9qqgz//fa2hUvSNLTS1jNMqmNKbRGrhtNuSlD
 zdbtFzhFvOsFNIneCK+VQ9gkwaCwg+K1S2nn6lWYin07ZH3oJeqBxfAkcD3K2Yzw0Z33I
X-Received: by 2002:a05:6820:a703:20b0:70a:549:292e with SMTP id
 006d021491bc7-71b394384b9mr383671eaf.28.1795114808197; 
 Thu, 19 Nov 2026 11:00:08 -0800 (PST)
Received: from [192.168.0.102] ([96.43.243.2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168bdba0sm321908a34.7.2026.11.19.11.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 11:00:07 -0800 (PST)
Message-ID: <43e84530-660f-4414-acac-5b0a02c43732@kernel.dk>
Date: Thu, 19 Nov 2026 12:00:06 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Excessive IO PSI for iothread when using io_uring since QEMU 10.2
From: Jens Axboe <axboe@kernel.dk>
To: John Maguire <jmaguire2013@gmail.com>, stefanha@redhat.com
Cc: f.ebner@proxmox.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, t.lamprecht@proxmox.com
References: <4EF13FE7-E6F3-42E2-83F9-635310B028DE@gmail.com>
 <3069e3f8-2cbf-436f-bf35-303fc90001ce@kernel.dk>
Content-Language: en-US
In-Reply-To: <3069e3f8-2cbf-436f-bf35-303fc90001ce@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=axboe@kernel.dk; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 8:58 AM, Jens Axboe wrote:
> On 11/15/26 4:05 PM, John Maguire wrote:
>> On Tue, Jun 02, 2026, Stefan Hajnoczi wrote:
>>> Pinging Jens: io_uring accounts POLL_ADD SQEs as blocking I/O activity
>>> whereas select(2)/poll(2)/epoll_wait(2) do not. Would it make sense to
>>> follow the same accounting as the syscalls for this operation since that
>>> is probably expected?
>>
>> Hello,
>>
>> I run Incus on two hosts and see misleading iowait and IO pressure on
>> both since Incus 7.6, which puts virtio disks on a dedicated iothread by
>> default. Incus users now hit this without opting into iothreads.
>>
>> Host 1: Arch Linux, stock QEMU 11.1.3, kernel 6.18.62, 16 CPUs, five
>> VMs. /proc/pressure/io shows about 80% "some" and 75% "full", with
>> 20-30% iowait. The disks are lightly loaded (under 15% util), there are
>> no D-state tasks, the pressure is confined to the cgroup holding the
>> QEMU processes, and each QEMU process has one thread in io_cqring_wait.
>> It started the day I upgraded from Incus 7.5.1 to 7.6; QEMU 11.1.x had
>> been in use on this host since late September without it.
>>
>> Host 2: Debian 13, kernel 6.12.116, 56 CPUs, four VMs, Zabbly's Incus
>> packages. These bundle QEMU 11.1.3 with the pve-qemu patch
>> "fdmon-io_uring: avoid idle event loop being accounted as IO wait".
>> Pressure is about 68% "some" and 65% "full" with disks under 1% util,
>> and again one thread per QEMU process in io_cqring_wait. This kernel
>> does not advertise IORING_FEAT_NO_IOWAIT (added in 6.15), so the patch
>> has no effect there.
>>
>> So the downstream patch only helps on 6.15+ kernels, and distros
>> shipping unpatched QEMU get these numbers by default.
>>
>> Is there a preferred way forward? Fiona offered to submit the Proxmox
>> workaround to qemu-devel, and Stefan asked whether io_uring should
>> instead account POLL_ADD the way poll(2) does. Either would fix this
>> for users on distro packages.
> 
> We can just queue up the patches for stable so they bubble back to
> older versions, I think that's the cleanest approach and gets us
> a unified interface across supported kernel versions.

I've prepared and tested patches for this for 6.12-stable, 6.6-stable,
and 6.1-stable. I'll send them in with the next batch. Once they are in,
all current and supported stable series will advertise
IORING_FEAT_NO_IOWAIT.

-- 
Jens Axboe

