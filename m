Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F342CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 10:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3XZg-0005QR-15; Tue, 30 Sep 2025 06:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3XZd-0005Pf-3i
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3XZU-0002Pb-4b
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759228014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q/09XWGkyjEeOLATbb8xvFMgB68kWsxuZEh27aoyp+c=;
 b=XzWuzuRgISJEWopLHtMtlSX2zWV/NB5ysD/pfVeMt0gJemwY9LvwmmtogNaQBdPxcqm+Gd
 A/fmU02/LC2TU8i7OpGAxyDN/moYF9BtXb5M0P22WkdujzV5wr4iZZMoUn81UJsAvegTGQ
 xxkDLeZpOFisrlhgZwHZS+4YOKJ21cM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-hs1fAQg0PHKFmmUFugbMyw-1; Tue, 30 Sep 2025 06:26:53 -0400
X-MC-Unique: hs1fAQg0PHKFmmUFugbMyw-1
X-Mimecast-MFC-AGG-ID: hs1fAQg0PHKFmmUFugbMyw_1759228012
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e3d43bbc7so22163145e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 03:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759228012; x=1759832812;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q/09XWGkyjEeOLATbb8xvFMgB68kWsxuZEh27aoyp+c=;
 b=OD9md/NJ8yQSis51gIhefDF+HIXggFCgwqRFzIU3SO/AdSg9p9zhUUz5MJVJUuojme
 CxkoiBHCUvfujVRBBsAxpcXYbwbXtiuNsYJocsGR/ZKsxLUP1fkhKYd7XpHaD81HSxlu
 IeQTm9hL7yybS6IiYquXxZWiAdyJLMWxMlrYXs/MksBV04UapO0cwVW7H15JBEbYXyZl
 NIu5U7KnPqawIn98lgt5kL/eZl/qMpTI7U9q4raAnWBGixXhFty8Gbt4+L4YBv3VpNLX
 rPr4L/mYtv2QfEiKsJ3c/cb+k0RZI1/cFHcMHhETfOSabzlcrT8nzso8QaWb5IXMNWjh
 4h/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoAAgRwWbcv6wslP26hPhQS4zgwqQmTxg/QboklZK/3pZI7eML5IZWNrvQGR147U0G99FolbbFdqME@nongnu.org
X-Gm-Message-State: AOJu0YwWbrZ2Sld6mjsMgoPGS13bFHM/D6mShlVZ5lgmuDAas17yAPLI
 Ws+cXTx6gksY2FMp44awQvlcnaaDbj9ZUKZ/XIGFusc8loDJzv2SgpKRyzH6v+koV7k75W3OzKW
 wXxelXTGH1v5O0pp4ZMCUOqrDfc5NxUya9FrVZmO+IWXh1z28Xt346ZSW
X-Gm-Gg: ASbGncu+0fQEjNk0hQVyRa426qMaGvIr1R/G585dpOOqdE3PcTRICiW/TaAQnqXlDNK
 7UVqOGxy99gVrPaQ85QUXDLeGz6ZwZD27SeFH35wK4+qg4RU30AzFyqjSWB0DEv2P93DV1rtWSS
 5HxvoQ8Gr0a2AB3kn6sy01QRSa64xXmQANrXx9fgglPbgskv3mpFdXI7ju0GyT7JmgbC0zRETkq
 TiLFyIUOqh5kpToN/mY7qeo9YJIUAT5GnTBy9vB4iiKadv+V+kWZjKG7dGlFJg1bPRu+75VhuKZ
 PeaqB+pWtsRKm88nBbftBmh1nb1hIvIIAqpcao1tIFSQ1of7tU6T+honFG3tBUwq5Jw/lzfjcAL
 VRfKbD1ofmQ==
X-Received: by 2002:a05:600c:83c8:b0:46e:4341:7302 with SMTP id
 5b1f17b1804b1-46e43419651mr114159535e9.34.1759228011781; 
 Tue, 30 Sep 2025 03:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiHzrcc3QawYT5ts8TLXSeyIIjna+LEXqQr9NFmPyleydqdGyvSXqduZ6kqlnZefudvktysg==
X-Received: by 2002:a05:600c:83c8:b0:46e:4341:7302 with SMTP id
 5b1f17b1804b1-46e43419651mr114159125e9.34.1759228011272; 
 Tue, 30 Sep 2025 03:26:51 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm22018035f8f.24.2025.09.30.03.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 03:26:50 -0700 (PDT)
Message-ID: <1ae8c90d-e296-42ee-967a-938006a1a0c2@redhat.com>
Date: Tue, 30 Sep 2025 12:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/28] hw/s390x/ipl: Create certificate store
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-5-zycai@linux.ibm.com>
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
In-Reply-To: <20250917232131.495848-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> Create a certificate store for boot certificates used for secure IPL.
> 
> Load certificates from the `boot-certs` parameter of s390-ccw-virtio
> machine type option into the cert store.
> 
> Currently, only X.509 certificates in PEM format are supported, as the
> QEMU command line accepts certificates in PEM format only.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst |  15 +++
>   hw/s390x/cert-store.c           | 213 ++++++++++++++++++++++++++++++++
>   hw/s390x/cert-store.h           |  39 ++++++
>   hw/s390x/ipl.c                  |  19 +++
>   hw/s390x/ipl.h                  |   3 +
>   hw/s390x/meson.build            |   1 +
>   include/hw/s390x/ipl/qipl.h     |   2 +
>   7 files changed, 292 insertions(+)
>   create mode 100644 docs/specs/s390x-secure-ipl.rst
>   create mode 100644 hw/s390x/cert-store.c
>   create mode 100644 hw/s390x/cert-store.h
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> new file mode 100644
> index 0000000000..9b1de5c604
> --- /dev/null
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -0,0 +1,15 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +s390 Certificate Store and Functions
> +====================================
> +
> +s390 Certificate Store
> +----------------------
> +
> +A certificate store is implemented for s390-ccw guests to retain within
> +memory all certificates provided by the user via the command-line, which
> +are expected to be stored somewhere on the host's file system. The store
> +will keep track of the number of certificates, their respective size,
> +and a summation of the sizes.
> +
> +Note: A maximum of 64 certificates are allowed to be stored in the certificate store.

fit into 80 columns, please.

> diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
> new file mode 100644
> index 0000000000..318acfb1f6
> --- /dev/null
> +++ b/hw/s390x/cert-store.c
> @@ -0,0 +1,213 @@
> +/*
> + * S390 certificate store implementation
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cert-store.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/option.h"
> +#include "qemu/config-file.h"
> +#include "hw/s390x/ebcdic.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
> +#include "qemu/cutils.h"
> +#include "crypto/x509-utils.h"
> +#include "qapi/qapi-types-machine-s390x.h"
> +
> +static BootCertificateList *s390_get_boot_certs(void)
> +{
> +    return S390_CCW_MACHINE(qdev_get_machine())->boot_certs;
> +}
> +
> +static size_t cert2buf(char *path, char **cert_buf)
> +{
> +    size_t size;
> +
> +    if (!g_file_get_contents(path, cert_buf, &size, NULL)) {
> +        return 0;
> +    }
> +
> +    return size;
> +}

What's the advantage of these wrapper functions? You seem to only use them 
in one spot, so I'd rather inline the code where it's used ==> less lines of 
code in total, and easier to read.


> +static void update_cert_store(S390IPLCertificateStore *cert_store,
> +                              S390IPLCertificate *cert)
> +{
> +    size_t data_buf_size;
> +    size_t keyid_buf_size;
> +    size_t hash_buf_size;
> +    size_t cert_buf_size;
> +
> +    /* length field is word aligned for later DIAG use */
> +    keyid_buf_size = ROUND_UP(CERT_KEY_ID_LEN, 4);
> +    hash_buf_size = ROUND_UP(CERT_HASH_LEN, 4);
> +    cert_buf_size = ROUND_UP(cert->der_size, 4);
> +    data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
> +
> +    if (cert_store->max_cert_size < data_buf_size) {
> +        cert_store->max_cert_size = data_buf_size;
> +    }
> +
> +    cert_store->certs[cert_store->count] = *cert;
> +    cert_store->total_bytes += data_buf_size;
> +    cert_store->count++;
> +}
> +
> +static GPtrArray *get_cert_paths(void)
> +{
> +    BootCertificateList *path_list = NULL;
> +    BootCertificateList *list = NULL;
> +    gchar *cert_path;
> +    GDir *dir = NULL;
> +    const gchar *filename;
> +    g_autoptr(GError) err = NULL;
> +    g_autoptr(GPtrArray) cert_path_builder = g_ptr_array_new_full(0, g_free);
> +
> +    path_list = s390_get_boot_certs();
> +    if (path_list == NULL) {
> +        return g_steal_pointer(&cert_path_builder);
> +    }
> +
> +    for (list = path_list; list; list = list->next) {
> +        cert_path = list->value->path;
> +
> +        if (g_strcmp0(cert_path, "") == 0) {
> +            error_report("Empty path in certificate path list is not allowed");
> +            goto fail;
> +        }
> +
> +        struct stat st;

QEMU coding style (see docs/devel/style.rst):

"Mixed declarations (interleaving statements and declarations within
blocks) are generally not allowed; declarations should be at the beginning
of blocks."

> +        if (stat(cert_path, &st) != 0) {
> +            error_report("Failed to stat path '%s': %s", cert_path, g_strerror(errno));
> +            goto fail;
> +        }
> +
> +        if (S_ISREG(st.st_mode)) {
> +            if (!g_str_has_suffix(cert_path, ".pem")) {
> +                error_report("Certificate file '%s' must have a .pem extension",
> +                             cert_path);
> +                goto fail;
> +            }
> +
> +            g_ptr_array_add(cert_path_builder, g_strdup(cert_path));
> +        } else if (S_ISDIR(st.st_mode)) {
> +            dir = g_dir_open(cert_path, 0, &err);
> +            if (dir == NULL) {
> +                error_report("Failed to open directory '%s': %s",
> +                             cert_path, err->message);
> +                goto fail;
> +            }
> +
> +            while ((filename = g_dir_read_name(dir))) {
> +                if (g_str_has_suffix(filename, ".pem")) {
> +                    g_ptr_array_add(cert_path_builder,
> +                                    g_build_filename(cert_path, filename, NULL));
> +                }
> +            }
> +
> +            g_dir_close(dir);
> +        } else {
> +            error_report("Path '%s' is neither a file nor a directory", cert_path);
> +            goto fail;
> +        }
> +    }
> +
> +    qapi_free_BootCertificateList(path_list);
> +    return g_steal_pointer(&cert_path_builder);
> +
> +fail:
> +    qapi_free_BootCertificateList(path_list);
> +    exit(1);

Doing "goto fail"s and then a clean-up and exit(1) at the end of the 
function looks weird. I think I'd rather either use "exit(1)" instead of 
"goto fail" thorough the function, or use a return NULL here and do the 
exit(1) in the caller instead (and maybe pass an "Error **errp" to the 
function here, replace all error_report with error_setg and do the 
error_report in the caller instead). Otherwise this looks just unbalanced.

> +}
> +
> +void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store)
> +{
> +    GPtrArray *cert_path_builder;
> +
> +    cert_path_builder = get_cert_paths();
> +    if (cert_path_builder->len == 0) {
> +        g_ptr_array_free(cert_path_builder, TRUE);
> +        return;
> +    }
> +
> +    if (cert_path_builder->len > MAX_CERTIFICATES - 1) {
> +        error_report("Cert store exceeds maximum of %d certificates", MAX_CERTIFICATES);
> +        g_ptr_array_free(cert_path_builder, TRUE);
> +        exit(1);

So there's a exit(1) here already ... that's another indication that it 
would be nicer to have the exit(1) from get_cert_paths() in this function 
here, too.

> +    }
> +
> +    cert_store->max_cert_size = 0;
> +    cert_store->total_bytes = 0;
> +
> +    for (int i = 0; i < cert_path_builder->len; i++) {
> +        S390IPLCertificate *cert = init_cert((char *) cert_path_builder->pdata[i]);

I'd suggest to do the same with init_cert(), i.e. add an "Error **errp" to 
it's parameter list and do the error_report() here.

> +        if (!cert) {
> +            g_ptr_array_free(cert_path_builder, TRUE);
> +            exit(1);
> +        }
> +
> +        update_cert_store(cert_store, cert);
> +    }
> +
> +    g_ptr_array_free(cert_path_builder, TRUE);
> +}

  Thomas


