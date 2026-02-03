Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C84BE8305B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAsX-0006Hx-8L; Tue, 03 Feb 2026 02:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnAsS-0006Gd-LK
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:31:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnAsP-0003Py-TS
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770103867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OlxsEFT0Dko9/Or/bR1K4IMxFA0xmHWvxzOGIBJCpAU=;
 b=XKDu2/CjJZ1fXC2c4w7c6X1f0Vh6/xVDmIVl4dzJyVgpv0XNUygHxmRcI1LuDm7/MSj+pw
 e52iyW/lBBR6Gr2kJsK0gcQise0CUyRfJ/8H141hCmS5hJh/yipkwuASpeKfzPw8fZnNkd
 TpU01kwLSGWndP0y6YBp+qi7K0ugYuc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-1B1IyxYiNb--0ZJ3nEgAwQ-1; Tue, 03 Feb 2026 02:31:04 -0500
X-MC-Unique: 1B1IyxYiNb--0ZJ3nEgAwQ-1
X-Mimecast-MFC-AGG-ID: 1B1IyxYiNb--0ZJ3nEgAwQ_1770103864
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-482d8e6e13aso34801645e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 23:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770103864; x=1770708664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OlxsEFT0Dko9/Or/bR1K4IMxFA0xmHWvxzOGIBJCpAU=;
 b=Tlcrt9W+z/PHaxGVydb0PwNPdYc8uXz3TjGVQMikrAtE0bxG4Ij1QGjoA/tQXA5SUM
 ll4FHY1yovXZSi6gJlD7abrvuLWFIahAwSWQK+weUZZ9gxoEmSmV9woynA+iSZKc66/Y
 sN88QJd05ovF9pMa3Sarn2t3u/ufzjs2+W5tQk2bqmptns4XANucQOpFMvLh/FNnemfu
 v1OKEtNIBvIVLMh8nAEv2m3qa/B+4LQBkZr2TDAZJ8NDuUR1zwsGyrO3R1LVjpDMP2Gm
 m0fSjiGXABYvIg4C45hr3aJVItTPbLTLfXHAk4vGHzJlXP4Dbvflc1z+oedNksw+jZ35
 9wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770103864; x=1770708664;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlxsEFT0Dko9/Or/bR1K4IMxFA0xmHWvxzOGIBJCpAU=;
 b=D1bJqV3ptFNbcRv3a2+GlLsTEYsmBoa25y/jKkYzA8lAqz2U8S+E1A1sSZ0aogzagW
 Zy9Zo1YX8za9D9veQcTFlAYb1r59MefZ9GD+D6610SRdNfCsli8QnLGLgclDNoZHIG69
 7RYLLsMFEKBvDaIgtakjSAGfkJKW4F8hJ9a4TbkYJZkqBdtpK/QZNAKlWWRDft/UdZpQ
 QGfiCkNvLqW9z7HbLYDx+hoM+oPPqYL3Wa5oq+hqyGB5NBa0MORexh74trLeeHqV6SDB
 DN76A/4Da+y4KhZA03BQQT7msMG173f0DB9cWs39zl6SW/KLHdgmngDbhXdw/bejjoJA
 87SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL3/zCFxt98R8pUthxUNic5nbx0KHKn6+HIIHE7K7kKIgh6Dp9rRM6XI692+3vqADKGIMIp+26sC6j@nongnu.org
X-Gm-Message-State: AOJu0Yy4GK7KDSaLERbYvW66GtCDM19IxUjvnVBybC2Pmq1xrIbbKJsi
 aClwuqo3VVMdeOiOvKPIE76FrHUnlRiWnQb+sQl17HLPo2N0Mdz7mrM4Z5oGqTEFx3qBJB+1LNh
 lkYyM06h0oPUGPqcAh15VtSx0sWDLcUCkDe03D4PzXu49amp7e2xoXE7m9YV4HdM9
X-Gm-Gg: AZuq6aLw9PoROozjDAwDE9IIC+1H+jP2JAHRtfm4h5hWdjPTAmLOcJ+Z6eSMWC57bOs
 caMwQZ8AC2Ld9nGmQNowNNjW1D2Qr7FVNorlCf+UCAErFaVnq0Ul6As06F9y6KJFTKP41bZxhNb
 4GPvNKK8VgM3UgZhRSG0VloU1r7yUlNwUrPkfjwOztNy3QnAA6gdnee5dLmwy+rU/REULb/2+Zt
 tnYgqEkdKPI+gklrJ9fLll+IYbk/ZSqGeFrXRSb9KT7iatzdj65Ltwnrv8mBmVxPdIa4ZjztgUD
 Pf14M4XPYmRAihfVHRBR2UGW691prAH0TRsV90SpuG9PDsMjhfDjsD2RnxJcTUi2DO+/LW3g5vn
 UUDdHZb8=
X-Received: by 2002:a05:600c:b99:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-482db49a4a6mr205493755e9.29.1770103863547; 
 Mon, 02 Feb 2026 23:31:03 -0800 (PST)
X-Received: by 2002:a05:600c:b99:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-482db49a4a6mr205493135e9.29.1770103863035; 
 Mon, 02 Feb 2026 23:31:03 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e297119bsm109433985e9.17.2026.02.02.23.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 23:31:02 -0800 (PST)
Message-ID: <20ffe5d6-4e20-4545-a794-122c324b1d86@redhat.com>
Date: Tue, 3 Feb 2026 08:30:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] disas: Have disas_set_info() take a const CPUState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Rolnik
 <mrolnik@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20260202222412.24923-1-philmd@linaro.org>
 <20260202222412.24923-8-philmd@linaro.org>
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
In-Reply-To: <20260202222412.24923-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 02/02/2026 23.24, Philippe Mathieu-Daudé wrote:
> The CPUClass::disas_set_info() handler is meant to initialize
> the %disassemble_info structure; it shoudn't alter the CPU state.
> Enforce the CPUState can not be modified by having the handler
> take a const pointer.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h   | 2 +-
>   target/alpha/cpu.c      | 3 ++-
>   target/arm/cpu.c        | 6 +++---
>   target/avr/cpu.c        | 2 +-
>   target/hexagon/cpu.c    | 3 ++-
>   target/hppa/cpu.c       | 2 +-
>   target/i386/cpu.c       | 6 +++---
>   target/loongarch/cpu.c  | 3 ++-
>   target/m68k/cpu.c       | 2 +-
>   target/microblaze/cpu.c | 2 +-
>   target/mips/cpu.c       | 7 +++++--
>   target/openrisc/cpu.c   | 2 +-
>   target/ppc/cpu_init.c   | 5 +++--
>   target/riscv/cpu.c      | 7 ++++---
>   target/rx/cpu.c         | 2 +-
>   target/s390x/cpu.c      | 2 +-
>   target/sh4/cpu.c        | 3 ++-
>   target/sparc/cpu.c      | 3 ++-
>   target/xtensa/cpu.c     | 3 ++-
>   19 files changed, 38 insertions(+), 27 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


