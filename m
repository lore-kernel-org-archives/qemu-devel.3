Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FD4C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lg2-0004Yl-6L; Tue, 15 Apr 2025 15:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1u4lfx-0004UO-UK
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:10:29 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1u4lfw-0005UJ-1l
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:10:29 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso4690937b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744744226; x=1745349026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=aBauhdBD41zRnYBCE0WbCTReSwUy13Xdi5xTsquRxOo=;
 b=MvvKnxdFFgWcW2f9sh48ecZxQkEwnCIsENuXxqqAmDsz6l3R9tURdOOKilx1kFEkwl
 VuXZ0bXobeojQhHcQxE6ZztbWwC05OfOaTpRKW/pUk+eBh7/2HHtU5/VRfz6W1EiUBF9
 5UXa8yjdAFmxcYTLoUrVDlIKBVvuDK9+zx0z8TxOb1VpR8/tdjS5aQ97L+kxJLaIKy8T
 sGr4KLeeSefl8OFo+27iPSlqA/3cHr/Bs7ixKbMIv+boFJ8mE7NPT1gyIOe8sWDXfokN
 I2M0amrFJIOI1onOryeEcH8hpAcYIDw5aImxnkCm5QLufxFNOIiPyYU/E4LlVww+Dm85
 WWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744744226; x=1745349026;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBauhdBD41zRnYBCE0WbCTReSwUy13Xdi5xTsquRxOo=;
 b=Jt3UN0GIVtFKQ6CWnW/F7wT+HPRXhhfhE0On5nZjZc0B8x9qFnpI1yyM0XH1f0NOVK
 Ri5kYX5GgXOjSDC9Z4SaEYxJnYIQvhYAeTHoyDoksDF+RA4dwmzNIpoN/eBPVcQVmSyV
 tqTv1VToKPtd8KK8rqVpd/cvPzlqi228zni92D6K0dhdJjECxyQeyZIrwlzWn7q2qJL9
 A+oZWzoJ2GKj5nX3Thgjp6qMg/eeQv5/CUCrAMXFbVtBWNqm6fK8f/kDYiPtU3elSWMV
 5Utr5+V546LW+6pSNXUIoggjbmBDpEtWI1ufSkxhfPpP5KDK1TyM4BBqrGlHNsCIgZwc
 3mkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzPlHoxeXpZddT+wRYNffnneKy3cUyHxRPq2ZlF5gW274e5H8rW4mk560Nq/DTpoRZtjhrgK0j4/z2@nongnu.org
X-Gm-Message-State: AOJu0YwQkxwAnHRm/z71CoLBRD/4dQsqc58qs0ZdU18S3Anx7AxdSVcx
 uGXwOgedIYrfPX6fQ6nmBvar6htF0HVuSFt0tpGjOkFJmsFruoDA
X-Gm-Gg: ASbGncv7x03z6O/pNtSNgYFQz2vAYywKSqlMUOBvSU5rvGiE5PBZ1KSbuf42AuMK2zp
 q4IG7awjDYw7ax5NjY69QuFlkNSOerRj6HdLhvRD8JUqsuuzYjZUKS5fpPm89haDOKYFr/ZKu1K
 kmtfu/xy+fQHuLtWu1yy3ZlaqX/hvY2hbtohV8eB53mj73fAJBzc0zFN6OWI4NTC/0gZTQbseJb
 QMiE+Z46cQqumF1/k9+gdH9QU8B6gHl8KxC5Fj7+AqkRXI7bHCRGv7TMemIY8tCxtBmwqbb/YxX
 zptrAq5oCHnhJ4mITYe8XC0yxBsCceCj3z3ASowWtm3NMBz1Z1Vo7mOUsePbFdU5io3uiGEtewR
 1RxRwQ/xE
X-Google-Smtp-Source: AGHT+IHl9ToY54I+z+AYWJGRIq6AtMdjvqfKXHT3Xe5MP7fY8TxBqLJunmvC5lth3YDfdiWDL+PTCw==
X-Received: by 2002:a05:6a00:1491:b0:73b:ac3d:9d6b with SMTP id
 d2e1a72fcca58-73c1f92cfc4mr1005672b3a.4.1744744225704; 
 Tue, 15 Apr 2025 12:10:25 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c45:45a3:affe:4635:b6b6:1a76?
 ([2401:4900:1c45:45a3:affe:4635:b6b6:1a76])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c33bfsm8860168b3a.42.2025.04.15.12.10.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 12:10:25 -0700 (PDT)
Message-ID: <9a37c921-3a1f-439e-b2c0-960a15b3c4eb@gmail.com>
Date: Wed, 16 Apr 2025 00:40:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 3/7] vhost: Forward descriptors to device via packed SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-4-sahilcdq@proton.me>
 <a878b49b-0d00-483a-a5b6-27d048c4ebc7@gmail.com>
 <CAJaqyWdAX6=ZvJdugW2_SmjQDZ31EhMfn=qodoWkZmjd2kY73A@mail.gmail.com>
 <2fa2b2b2-dc9f-4a63-b24f-50cb190dadcf@gmail.com>
 <CAJaqyWfwUqek9McKYZoDpPxf-woxw0g8AJ589W9t6LSdqzdniQ@mail.gmail.com>
 <5f970447-2547-4ce2-8d27-420540d5896b@gmail.com>
 <CAJaqyWdJCaP79Pvy1YgkrZC4p7HBsg1U5MDmQR-LLDFmrBGSzg@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 xsDNBGcgaYEBDADpKUSKbchLCMdCuZGkuF50/7BiraKc8Ch+mk4T+2+E2/6qXAkalvCkFoqx
 3/sa35rconZAFzB/r19e7i3UajIQjATvENrGxqe/IFqcJxo2Jr1HQBwCrsmlQoUCilSC6nDi
 ejcEIAFytJORDkCcZwLXPjdf5/4pbqVAW5823LB5j5F0TqHAnGY1RhS2V1eBPdRqjAA3xecT
 zTmLHlkqAXgM2DOot1KbycedZSieCwEykTXMaLC0/3Gyo2Cp1WTWOIyD0hsXpLyFioV4FaX2
 Lm+z45Zc4PoNXeC6+l4PdDxixs+saAbadknP+9omwlb+PkMd3esq2wkowTwTJVJK8FCCNTo5
 2OArA/ddxcyXY25JHN7vzGooFNW6Bb9YV+lbX6y95ytE3KcAmid73tQrcjlebIpgNAvOMyyZ
 BgQJY0HSu3DGNZuKtbNM3iTl82TFj7MVgkEffgF83N6XyBqDztIz2lN47/q5wyRi3jda9NDt
 geI+Nv145HjulO7bI3NT048AEQEAAc0kU2FoaWwgU2lkZGlxIDxpY2VnYW1iaXQ5MUBnbWFp
 bC5jb20+wsENBBMBCAA3FiEERtYfQYWFu+uAZjYrrzGlXdb6f1cFAmcgaYEFCQWjmoACGwME
 CwkIBwUVCAkKCwUWAgMBAAAKCRCvMaVd1vp/V/nnC/9KnNIr4a3JW3E/snxv1+XIyUmHBDLn
 PKBmLDYxO9RJe1xKo/sNmLEno4c8G1F/y12TLV086cpBYGKkE8mPMBABqxuiPG8srwoKc2HW
 bvoC2Zfeu/WeQ0YqeI9ZEwRhsDGQZ7vc8PnKnEUaPZn6iWW4GeX7dXWeGNrK0wU2B04l2d+M
 FIKaoPHk8w5Ff++QNcn0YRkm//nYlukHUrMxhNcuc18jaLLftOh7BH/4EbKtTN75KAFePQBi
 I2CbuC41fchTt12QrPB3yz1GKfudsEMLFHBNeComJNnuolPOq0YSyuKdRO8Jubn5ZqWQeTwj
 XbG7wTonDc8xe46irOhz36VcjsjSY+PYhVZSeDWeDUZgpaJkBjQDDodIN2eoMwVEyUByos9H
 mKrqrpBMmylOspAZzqjb5FtOqM0BCxQINdKKiMwRelSb6pHYCrbS0XzpwDUEpp7RWCbHgg+6
 Ot72kQCEFxj2LzX9VxF24GGQy9inlUfN51IV04klSibtBuuz/NbOwM0EZyBpgQEMAJelVX4k
 CtCxD4Ji3FQ8LZs22z7VoUvqIb7Gj2lNvhPeijlqqBkSMIgnSCLxlH4ahqKnEV58IrfVriV0
 92zb94Az2nl0r+bZYfvev1qCcVIYxk+pYYcRl5qPXX8XGalrkcBBWmkgTSwzNK9rV4850iVI
 hsJNel49qen9JwiFYMSKa2MYgdYSbeuuwXwUp0ZHeVFc5RnPK2wxws1xcnsdb9hRXs2UeTEE
 0klG3HuXqJ96DzKrCieKHLjs330h+16gDWAFZSEoT7Mh3HFGI2dscVuBstQNgnwUMnsJv8jx
 c005CfLCjCBnJEhMd2/QFuLwCZv4IdoghKwYw18e61UbX2bFovo9dduD527pD4sFqi7U7ofv
 aO3yf+ulL6jiKypGvnbiBP3KY3aKxx6pHHH3aDc9eOqCUgrtS3+xt1du4+qxrYqEnrywFoJy
 5zqSzbnTTjFpdTbY5SS52fIOktLlAKzEg6V9hkg2r08hC3/L4NVj6I4tsGZlqb2neRlHFmCr
 bQARAQABwsD8BBgBCAAmFiEERtYfQYWFu+uAZjYrrzGlXdb6f1cFAmcgaYIFCQWjmoACGwwA
 CgkQrzGlXdb6f1fDIgwAmpB7eL3XNSx3F+gbmksOPMqCU5rEswRedjEt6tBzFTXhdNFfhZTb
 vCddUNePZnzddgxAnDBcTqI1jx6Go6Hkti/mxJqXSczMYBsImD/lEm47axsADvpnNaEM+tmu
 m/cMKfpILUpy2Ey7CKXUA1vpzYeUD29EQWi0fxM0arplrVt/uzUdFRFQRn2hCqeDLBLONX1F
 Adq+re6M0dhKl4a2+erzZRIXh3vIGiDmpJEGrajrhqEnMXFp6toSiMGian94m8H3NT6rB64E
 JmdHgyjXADFbn2G5Mb6Pwa8KnnK1kYcZ+Pwu9LfMXfgI01Sh/k01hjUVmnpYep4nHUfwXA8r
 kn6WekD80DYbAfKyFAXQCO/nclZ82RNmJbDRi3AeMFrxKi6KgdGCp1Izhj9USaMOVqcuV2p0
 Rsoq+sFqWOKaHWnQHCM9RkynQVqrgUaSawEbGlCP1KIhVmjfjVsmsCaKkUb9T6VeO+ZNe+Pn
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWdJCaP79Pvy1YgkrZC4p7HBsg1U5MDmQR-LLDFmrBGSzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On 4/14/25 8:37 PM, Eugenio Perez Martin wrote:
> On Mon, Apr 14, 2025 at 11:38 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>> On 3/28/25 1:21 PM, Eugenio Perez Martin wrote:
>>> On Thu, Mar 27, 2025 at 7:42 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>> On 3/26/25 1:33 PM, Eugenio Perez Martin wrote:
>>>> [...]
>>> I think both approaches should be valid. My advice is to follow
>>> Linux's code and let it be the tail descriptor id. This descriptor id
>>> is pushed and popped from vq->free_head in a stack style.
>>>
>>> In addition to that, Linux also sets the same id to all the chain
>>> elements. I think this is useful when dealing with bad devices. In
>>> particular,
>>
>> Understood. So far, I have implemented this so it matches the
>> implementation in Linux.
>>
>>> QEMU's packed vq implementation looked at the first
>>> desciptor's id, which is an incorrect behavior.
>>
>> Are you referring to:
>>
>> 1. svq->desc_state[qemu_head].elem = elem (in vhost_svq_add()), and
>> 2. *head = id (in vhost_svq_add_packed())
>>
> 
> I meant "it used to use the first descriptor id by mistake". It was
> fixed in commit 33abfea23959 ("hw/virtio: Fix obtain the buffer id
> from the last descriptor"). It is better to set the descriptor id in
> all the descriptors of the chain, so if QEMU does not contain this
> patch in the nested VM case it can still work with this version.
> 

Oh, ok. I have understood this now.

Thanks,
Sahil

