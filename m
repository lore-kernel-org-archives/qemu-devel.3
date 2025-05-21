Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC88AC3ABC9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 12:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHihW-0001HI-2J; Wed, 21 May 2025 08:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHihQ-0001DS-Vv
 for qemu-devel@nongnu.org; Wed, 21 May 2025 08:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHihK-0002TS-P5
 for qemu-devel@nongnu.org; Wed, 21 May 2025 08:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747831044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2N+4ApS24VtDL4bEGdgdwf4mRC/SaT1gobKO/o0VcDo=;
 b=GSBqMoJNwIrB4dJrmaNGMAtI5aiOFFjzx1J0LxCOMfKBuEWLoOKw+W/jqq1AC15lidXXO5
 OAHMjFktZ17iiSj3buKXPEn9bQYVdLcTriUxT0Jf1lDBLfws30f3hpzoJ5yT0g8JnUZw5y
 aymWkArUvWrD/Fr7U7uFEEjkLXq1Jq4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-JMcld4nDMvel6wk-elNMIw-1; Wed, 21 May 2025 08:37:23 -0400
X-MC-Unique: JMcld4nDMvel6wk-elNMIw-1
X-Mimecast-MFC-AGG-ID: JMcld4nDMvel6wk-elNMIw_1747831042
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3292056b45eso15181381fa.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 05:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747831041; x=1748435841;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2N+4ApS24VtDL4bEGdgdwf4mRC/SaT1gobKO/o0VcDo=;
 b=VrV/1giF2uUb7OArlzRqnPPnIlLlT/OAI4261Q9VWAbwQFFVcXhPpySZrm4vOXMmub
 qbTue3n/KlqWgFYym1BqzADpI4WjZeHJcD3zvFGvMCqIR2bkGZRtwE82NXIlLOdCJX3a
 yfA/HHyC06YPXxDeOvo1muotMS3uMWGYEdvO5wPpct8Ba7h+221LZU6KAcWsVmWfAYei
 1VWx8+io568AsL9tH0/fEgMxm+C39AkbMkRt/gYCAn2N/zBq24hXnuQRa1B7g0TDi/44
 XI/8nMZQ7YthbysWkD9IyMPmUQt8pZb09X6b2kcbYqPJs9nqYvkHRVpVlZgaCLQIGgWy
 HouA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKLTCTCXUzjLQ23qmBkQpe28YpbE8ZOgpkcS4KZX8ERM0IbrgRtMOlchUHRCOeisXmn0PI1q5YE24X@nongnu.org
X-Gm-Message-State: AOJu0YyZfWfYrTKUfSg9e/FJoQiyxOLZQWbpJ31OPPQyy/QG4SDi+Neu
 0xl9AEqV4maxy26pkWhKB7cuKiEBpoo15acZTdIjFDIe+6UKYtOysPRgrqETqwiIFu71YwGXyh2
 LAsfsWhEKL26234d8w5H7jLncPztkDUilILBbo1iMeStK5TWpFOQCJkMJ
X-Gm-Gg: ASbGnctCqGj0eGq/we9Tu7BULK6q02TaVtpAyfgt59VVuFHhFey9QMP0FDz455WcVD/
 8ro8EYX/EJs/a37bjyMyQ6NokUkTBbgnekctBjzykjWSQurNYLo+UmKhiTQH6VME1i6MPluRhs4
 NVyfsbg08jxDyYVxtNeysIayzj1bNMnf4W9Zsm5Ts23kYiynbL63BIk5Z7zcrPK5aOzVp8mT7RJ
 ELHyL8A3h+DL+GoulDxPSq9nQ8v/kk6GxDFf13s9TdZeCxGehygtKJE/o0aQwSwNo60RE2TqbcL
 qTxV4RbVTGrGfCDbTCMxrSyBOjLVERNG8JlQ3C/6xig=
X-Received: by 2002:a2e:8a9c:0:b0:30c:c8d:ba3c with SMTP id
 38308e7fff4ca-32807745937mr54400491fa.17.1747831041360; 
 Wed, 21 May 2025 05:37:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9O5mcOrX6CdiIgqwVmMcZp1TeoVxERw6LEgti7kiboV0pGELRXJm8BKfi1H8jb5R9upEwQg==
X-Received: by 2002:a2e:8a9c:0:b0:30c:c8d:ba3c with SMTP id
 38308e7fff4ca-32807745937mr54400341fa.17.1747831040762; 
 Wed, 21 May 2025 05:37:20 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-32809511dd9sm27174101fa.51.2025.05.21.05.37.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 05:37:20 -0700 (PDT)
Message-ID: <4e170da7-3ffd-4edb-8695-a3abc9333c75@redhat.com>
Date: Wed, 21 May 2025 14:37:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/25] docs/system/s390x: Add secure IPL documentation
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-26-zycai@linux.ibm.com>
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
In-Reply-To: <20250508225042.313672-26-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 09/05/2025 00.50, Zhuoying Cai wrote:
> Add documentation for secure IPL.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/system/s390x/secure-ipl.rst | 249 +++++++++++++++++++++++++++++++
>   1 file changed, 249 insertions(+)
>   create mode 100644 docs/system/s390x/secure-ipl.rst
> 
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> new file mode 100644
> index 0000000000..4f80d7741e
> --- /dev/null
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -0,0 +1,249 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +s390 Secure IPL
> +===============
> +
> +Secure IPL, also known as secure boot, enables s390-ccw virtual machines to
> +leverage qcrypto libraries and z/Arch implementations to verify the integrity of
> +guest kernels. These operations are rely on userspace invocations and QEMU
> +interpretation.

I don't understand the last sentence. Could you please rephrase it?

> The user provides one or more certificates via the command line
> +options, which populates a certificate store. DIAGNOSE 'X'320' is invoked by
> +userspace to query cert store info and retrieve specific certificates from QEMU.
> +DIAGNOSE 'X'508' is used by userspace to leverage qcrypto libraries to perform
> +signature-verification in QEMU. Lastly, userspace generates and appends an
> +IPL Information Report Block (IIRB) at the end of the IPL Parameter Block.
> +
> +The steps are as follows:
> +
> +- Userspace retrieves data payload from disk (e.g. stage3 boot loader, kernel)
> +- Userspace checks the validity of the SCLAB
> +- Userspace invokes DIAG 508 subcode 1 and provides it the payload
> +- QEMU handles DIAG 508 request by reading the payload and retrieving the
> +  certificate store
> +- QEMU DIAG 508 utilizes qcrypto libraries to perform signature-verification on
> +  the payload, attempting with each cert in the store (until success or
> +  exhausted)
> +- QEMU DIAG 508 returns:
> +
> +  - success: index of cert used to verify payload
> +  - failure: error code

So this doc is rather meant as a specification, not as a documentation for 
the end user? In that case it should maybe rather reside in docs/specs/ and 
not in docs/system/s390x.

> +- Userspace responds to this operation:
> +
> +  - success: retrieves cert from store via DIAG 320 using returned index
> +  - failure: reports with warning (audit mode), aborts with error (secure mode)
> +
> +- Userspace appends IIRB at the end of the IPLB
> +- Userspace kicks off IPL
> +
> +
> +Constraints
> +-----------
> +
> +The following constraints apply when attempting to secure IPL an s390 guest:
> +
> +- z16 CPU model
> +- certificates must be in X.509 DER format
> +- only sha256 encryption is supported
> +- only support for SCSI scheme of virtio-blk/virtio-scsi devices
> +- a boot device must be specified
> +- any unsupported devices (e.g., ECKD and VFIO) or non-eligible devices (e.g.,
> +  Net) will cause the entire boot process terminating early with an error
> +  logged to the console.
> +
> +
> +s390 Certificate Store
> +======================
> +
> +Secure boot relies on user certificates for signature-verification. Normally,
> +these certificates would be stored somewhere on the LPAR. Instead, for virtual
> +guests, a certificate store is implemented within QEMU. This store will read
> +any certificates provided by the user via command-line, which are expected to
> +be stored somewhere on the host file system. Once these certificates are
> +stored, they are ready to be queried/requested by DIAGNOSE 'X'320' or used for
> +verification by DIAGNOSE 'X'508'.
> +
> +The certificate store can be populated by supplying a comma-delimited list of
> +certificates on the command-line:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio, \
> +    boot-certificates=/.../qemu/certs:/another/path/cert.der
> +
> +
> +DIAGNOSE function code 'X'320' - Certificate Store Facility
> +-----------------------------------------------------------
> +
> +DIAGNOSE 'X'320' is used to provide support to query the certificate store.
> +
> +Subcode 0 - query installed subcodes
> +    Returns a 256-bit installed subcodes mask (ISM) stored in the installed
> +    subcodes block (ISB). This mask indicates which sucodes are currently
> +    installed and available for use.
> +
> +Subcode 1 - query verification certificate storage information
> +    Provides the information required to determine the amount of memory needed to
> +    store one or more verification-certificates (VCs) from the certificate store (CS).
> +
> +    Upon successful completion, this subcode returns various storage size values for
> +    verification-certificate blocks (VCBs).
> +
> +    The output is returned in the verification-certificate-storage-size block (VCSSB).
> +
> +Subcode 2 - store verification certificates
> +    Provides VCs that are in the certificate store.
> +
> +    The output is provided in a VCB, which includes a common header followed by zero
> +    or more verification-certificate entries (VCEs).
> +
> +    The first-VC index and last-VC index fields of VCB specify the range of VCs
> +    to be stored by subcode 2. Stored count and remained count fields specify the
> +    number of VCs stored and could not be stored in the VCB due to insufficient
> +    storage specified in the VCB input length field.
> +
> +    VCE contains various information of a VC from the CS.
> +
> +
> +IPL Modes
> +=========
> +
> +Different IPL modes may be toggled with the following command line option:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on|off
> +
> +Additionally, the provision of certificates affect the mode.
> +
> +
> +Normal Mode
> +-----------
> +
> +The absence of both certificates and the ``secure-boot`` option will attempt to
> +IPL a guest without secure IPL operations. No checks are performed, and no
> +warnings/errors are reported.  This is the default mode, and can be explicitly
> +enabled with ``secure-boot=off``.
> +
> +
> +Audit Mode
> +----------
> +
> +With *only* the presence of certificates in the store, it is assumed that secure
> +boot operations should be performed with errors reported as warnings. As such,
> +the secure IPL operations will be performed, and any errors that stem from these
> +operations will report a warning via the SCLP console.
> +
> +
> +Secure Mode
> +-----------
> +
> +With *both* the presence of certificates in the store and the ``secure-boot=on``
> +option, it is understood that secure boot should be performed with errors
> +reported and boot will abort.
> +
> +
> +Secure IPL Functions
> +====================
> +
> +IPL Information Report Block
> +----------------------------
> +
> +The IPL Parameter Block (IPLPB), utilized for IPL operation, is extended with an
> +IPL Information Report Block (IIRB), which contains the results from secure IPL
> +operations such as:
> +
> +* component data
> +* verification results
> +* certificate data
> +
> +
> +Secure Code Loading Attributes Facility
> +---------------------------------
> +
> +Secure Code Loading Attributes Facility (SCLAF) provides additional security during IPL.
> +
> +When SCLAF is available, its behavior depends on the IPL Modes.
> +
> +* secure mode: IPL will terminate on any errors detected by this facility.
> +* audit mode:  IPL may proceed regardless of any errors detected by this facility.
> +
> +Errors detected by the SCLAF are reported in IIRB.
> +
> +Unsigned components may only be loaded at absolute storage address x’2000’ or higher.
> +
> +Signed components must include a Secure Code Loading Attribute Block (SCLAB),
> +which is located at the very end of the signed component.
> +
> +**Secure Code Loading Attribute Block (SCLAB)**
> +
> +The SCLAB is located at the end of each signed component. It defines the code loading
> +attributes for the component and may:
> +
> +* Provide direction on how to process the rest of the component.
> +
> +* Provide further validation of information on where to load the signed binary code
> +  from the load device.
> +
> +* Specify where to start the execution of the loaded OS code.
> +
> +
> +DIAGNOSE function code 'X'508' - KVM IPL extensions
> +---------------------------------------------------
> +
> +DIAGNOSE 'X'508' is reserved for KVM guest use in order to facilitate
> +communication of additional IPL operations that cannot be handled by userspace,
> +such as signature verification for secure IPL.
> +
> +If the function code specifies 0x508, KVM IPL extension functions are performed.
> +These functions are meant to provide extended functionality for s390 guest boot
> +that requires assistance from QEMU.
> +
> +Subcode 0 - query installed subcodes
> +    Returns a 64-bit mask indicating which subcodes are supported.
> +
> +Subcode 1 - perform signature verification
> +    Used to perform signature-verification on a signed component, leveraging
> +    qcrypto libraries to perform this operation and pulling from the certificate
> +    store.
> +
> +
> +Secure IPL Quickstart
> +=====================
> +
> +Build QEMU with gnutls enabled:
> +
> +.. code-block:: shell
> +
> +    ./configure … --enable-gnutls
> +
> +Generate certificate (e.g. via openssl):
> +
> +.. code-block:: shell
> +
> +    openssl req -new -x509 -newkey rsa:2048 -keyout mykey.priv \
> +                -outform DER -out mycert.der -days 36500 \
> +                -subj "/CN=My Name/" -nodes
> +
> +Sign Images (e.g. via sign-file):
> +
> +- signing must be performed on a KVM guest filesystem
> +- sign-file script used in the example below is located within the kernel source
> +  repo
> +
> +.. code-block:: shell
> +
> +    ./sign-file sha256 mykey.priv mycert.der /boot/vmlinuz-…
> +    ./sign-file sha256 mykey.priv mycert.der /usr/lib/s390-tools/stage3.bin
> +
> +Run zipl with secure boot enabled
> +
> +.. code-block:: shell
> +
> +    zipl --secure 1 -V
> +
> +Start Guest with Cmd Options:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certificates=mycert.der ...

So that quickstart section looks like it could be useful for the end user? 
Maybe you could split your doc up into two part, one going into 
docs/system/s390x/ for the normal users, and one going into docs/specs/ as 
technical reference for the developers?

  Thomas


