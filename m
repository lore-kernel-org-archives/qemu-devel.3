Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B943C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 18:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEYre-0008Nd-RJ; Tue, 04 Jun 2024 14:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEYrd-0008NI-IZ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEYra-0002ey-Gp
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717525584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YS19AbTMFU+jlGpWCQBqBS2/Uln/hroqiE4e86QoM9E=;
 b=JFWMGozIeHYeuuruMV9WU0iazR8q6qhfMgQRE3vtPHlYobZ6FnFhm2R59Hh8CO1WWtL18i
 DFoXwJ3WK+HtLv67AdMvGAHe2Zb5Yffikr3cUiPwjWdTrBMh7G1FKeDfcDSC1ezzkBppMV
 J+0dN+vCFd+YC0FA1WFN2o/FuKnU0fI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-TIJFKXQTODujCpjrPvN3tg-1; Tue, 04 Jun 2024 14:26:22 -0400
X-MC-Unique: TIJFKXQTODujCpjrPvN3tg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4212e3418b1so28606745e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 11:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717525581; x=1718130381;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YS19AbTMFU+jlGpWCQBqBS2/Uln/hroqiE4e86QoM9E=;
 b=jdo5k2xnnmZysovRrp68E6NLCcimP2PSWLVFB2fZaVZb7fi6VZNdUuVINGSdCDqHw4
 mco4tQL7499n/UyVoSdnQH3SZi554TzC6DMLKhcrVB/tObBjYShDv077oPdoWaLDCq3M
 QNT4jZ9GzTKxk47m39he9CiFYGZcuccrp/Ucfo9tMknSKFlvMmVD20RmpwKcIv7cA9Qc
 ZCegQtzloWtAoMdQ/SGBkPsshDVmEqkOWN4uOslqvG6+OfwJNgKojhIrfvChxLgTM+p3
 Fo7EZrG1ypJcS3fyyYGuol6pw9MPY0EdC65b7GoHdV4LgL0pAPOM1fkdi7BMgfwsPm4F
 AGsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ5l5Mw8Ds8hLN4LGHiMoB35TgU5EOphHV/lF+WGUdRDtjBMAHKpYdaZFrV+YSGpWfBp+VF176v5GWU+Klc6RZaru8HoA=
X-Gm-Message-State: AOJu0YyQLDkB4Vf9NkkvKuXQ89slBJaiLiebg07EmdhRmIIx0t8naagy
 cP8+/VbLUCSsSf9ABnBA2nFYF+F2OHSP8t7KAHlCGjAoUvz6cJcX0cH6yaKCLP6WMoqQdL0h4WI
 CqnkAzNRPHptX48m2tO2JnuxJUee8jTO+qnZJs5NppsY5D26+Ya50
X-Received: by 2002:a05:600c:458d:b0:420:2983:2229 with SMTP id
 5b1f17b1804b1-421562e6358mr3284175e9.22.1717525581075; 
 Tue, 04 Jun 2024 11:26:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvhQTQfCUVUuUCpvphywVf+HLilkkAJcFJYkYd2Zx2WCA0rixxwAA2YkwGrG3kGNEFKIUg7g==
X-Received: by 2002:a05:600c:458d:b0:420:2983:2229 with SMTP id
 5b1f17b1804b1-421562e6358mr3284015e9.22.1717525580618; 
 Tue, 04 Jun 2024 11:26:20 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-97.web.vodafone.de.
 [109.43.178.97]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4214a4abdd5sm21325105e9.0.2024.06.04.11.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 11:26:20 -0700 (PDT)
Message-ID: <722f7af6-a5f0-4528-a327-a897255f7ea8@redhat.com>
Date: Tue, 4 Jun 2024 20:26:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] s390x: Build IPLB chain for multiple boot devices
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-4-jrossi@linux.ibm.com>
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
In-Reply-To: <20240529154311.734548-4-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 29/05/2024 17.43, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Write a chain of IPLBs into memory for future use.
> 
> The IPLB chain is placed immediately before the BIOS in memory at the highest
> unused page boundary providing sufficient space to fit the chain. Because this
> is not a fixed address, the location of the next IPLB and number of remaining
> boot devices is stored in the QIPL global variable for later access.
> 
> At this stage the IPLB chain is not accessed by the guest during IPL.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   hw/s390x/ipl.h              |   1 +
>   include/hw/s390x/ipl/qipl.h |   4 +-
>   hw/s390x/ipl.c              | 129 +++++++++++++++++++++++++++---------
>   3 files changed, 103 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 1dcb8984bb..4f098d3a81 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -20,6 +20,7 @@
>   #include "qom/object.h"
>   
>   #define DIAG308_FLAGS_LP_VALID 0x80
> +#define MAX_IPLB_CHAIN 7
>   
>   void s390_ipl_set_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
>   void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index a6ce6ddfe3..481c459a53 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -34,7 +34,9 @@ struct QemuIplParameters {
>       uint8_t  reserved1[3];
>       uint64_t netboot_start_addr;
>       uint32_t boot_menu_timeout;
> -    uint8_t  reserved2[12];
> +    uint8_t  reserved2[2];
> +    uint16_t num_iplbs;
> +    uint64_t next_iplb;
>   }  QEMU_PACKED;
>   typedef struct QemuIplParameters QemuIplParameters;
>   
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 2d4f5152b3..79429acabd 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -55,6 +55,13 @@ static bool iplb_extended_needed(void *opaque)
>       return ipl->iplbext_migration;
>   }
>   
> +/* Start IPLB chain from the boundary of the first unused page before BIOS */

I'd maybe say "upper boundary" to make it clear that this is at the end of 
the page, not at the beginning?

> +static uint64_t find_iplb_chain_addr(uint64_t bios_addr, uint16_t count)
> +{
> +    return (bios_addr & TARGET_PAGE_MASK)
> +            - (count * sizeof(IplParameterBlock));
> +}
> +
>   static const VMStateDescription vmstate_iplb_extended = {
>       .name = "ipl/iplb_extended",
>       .version_id = 0,
> @@ -391,6 +398,17 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
>       return ccw_dev;
>   }
>   
> +static void s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
> +{
> +    S390IPLState *ipl = get_ipl_device();
> +    uint16_t count = ipl->qipl.num_iplbs;
> +    uint64_t len = sizeof(IplParameterBlock) * count;
> +    uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
> +
> +    cpu_physical_memory_write(chain_addr, iplb_chain, be32_to_cpu(len));

The be32_to_cpu looks wrong here, since you just computed len in native 
endianness.

> +    ipl->qipl.next_iplb = chain_addr;

Just a matter of taste, but I'd prefer to set ipl->qipl.next_iplb in the 
same function where you set ipl->qipl.num_iplbs ... so I'd rather return 
chain_addr here and then do this on the calling site:

	ipl->qipl.next_iplb = s390_ipl_map_iplb_chain(...);
> +}
> +
>   void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
>   {
>       int i;
> @@ -422,54 +440,51 @@ void s390_ipl_set_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
>       }
>   }
>   
> -static bool s390_gen_initial_iplb(S390IPLState *ipl)
> +static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>   {
> -    DeviceState *dev_st;
> +    S390IPLState *ipl = get_ipl_device();
>       CcwDevice *ccw_dev = NULL;
>       SCSIDevice *sd;
>       int devtype;
>       uint8_t *lp;
>   
> -    dev_st = get_boot_device(0);
> -    if (dev_st) {
> -        ccw_dev = s390_get_ccw_device(dev_st, &devtype);
> -    }
> -
>       /*
>        * Currently allow IPL only from CCW devices.
>        */
> +    ccw_dev = s390_get_ccw_device(dev_st, &devtype);
>       if (ccw_dev) {
>           lp = ccw_dev->loadparm;
>   
> -        switch (devtype) {
> -        case CCW_DEVTYPE_SCSI:
> +         switch (devtype) {
> +         case CCW_DEVTYPE_SCSI:
>               sd = SCSI_DEVICE(dev_st);
> -            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
> -            ipl->iplb.blk0_len =
> +            iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
> +            iplb->blk0_len =
>                   cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
> -            ipl->iplb.pbt = S390_IPL_TYPE_QEMU_SCSI;
> -            ipl->iplb.scsi.lun = cpu_to_be32(sd->lun);
> -            ipl->iplb.scsi.target = cpu_to_be16(sd->id);
> -            ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
> -            ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
> -            ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
> +            iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
> +            iplb->scsi.lun = cpu_to_be32(sd->lun);
> +            iplb->scsi.target = cpu_to_be16(sd->id);
> +            iplb->scsi.channel = cpu_to_be16(sd->channel);
> +            iplb->scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
> +            iplb->scsi.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           case CCW_DEVTYPE_VFIO:
> -            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> -            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
> -            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
> -            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
> +            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> +            iplb->pbt = S390_IPL_TYPE_CCW;
> +            iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
> +            iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           case CCW_DEVTYPE_VIRTIO_NET:
> +            /* The S390IPLState netboot is ture if ANY IPLB may use netboot */
>               ipl->netboot = true;
>               /* Fall through to CCW_DEVTYPE_VIRTIO case */
>           case CCW_DEVTYPE_VIRTIO:
> -            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> -            ipl->iplb.blk0_len =
> +            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> +            iplb->blk0_len =
>                   cpu_to_be32(S390_IPLB_MIN_CCW_LEN - S390_IPLB_HEADER_LEN);
> -            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
> -            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
> -            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
> +            iplb->pbt = S390_IPL_TYPE_CCW;
> +            iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
> +            iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           }
>   
> @@ -478,8 +493,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>               lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
>           }
>   
> -        s390_ipl_set_loadparm((char *)lp, ipl->iplb.loadparm);
> -        ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
> +        s390_ipl_set_loadparm((char *)lp, iplb->loadparm);
> +        iplb->flags |= DIAG308_FLAGS_LP_VALID;
>   
>           return true;
>       }
> @@ -487,6 +502,58 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>       return false;
>   }
>   
> +static bool s390_init_all_iplbs(S390IPLState *ipl)
> +{
> +    int iplb_num = 0;
> +    IplParameterBlock iplb_chain[7];
> +    DeviceState *dev_st = get_boot_device(0);
> +
> +    /*
> +     * Parse the boot devices.  Generate an IPLB for the first boot device,
> +     * which will later be set with DIAG308. Index any fallback boot devices.
> +     */
> +    if (!dev_st) {
> +        ipl->qipl.num_iplbs = 0;
> +        return false;
> +    }
> +
> +    iplb_num = 1;
> +    s390_build_iplb(dev_st, &ipl->iplb);
> +    ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
> +
> +    while (get_boot_device(iplb_num)) {
> +        iplb_num++;
> +    }
> +
> +    ipl->qipl.num_iplbs = iplb_num - 1;

It's somewhat confusing that ipl->qipl.num_iplbs is one less than iplb_num 
... what does ipl->qipl.num_iplbs exactly define? The amount of additional 
chained devices beside the first one?

A comment either here or qipl.h that describes the exact meaning of 
num_iplbs would be helpful.

> +
> +    /*
> +     * Build fallback IPLBs for any boot devices above index 0, up to a
> +     * maximum amount as defined in ipl.h
> +     */
> +    if (iplb_num > 1) {
> +        if (iplb_num > MAX_IPLB_CHAIN) {
> +            warn_report("Excess boot devices defined! %d boot devices found, "
> +                        "but only the first %d will be considered.",
> +                        iplb_num, MAX_IPLB_CHAIN + 1);
> +            iplb_num = MAX_IPLB_CHAIN + 1;

What's now the real maximum number of iplb_num ? If it is MAX_IPLB_CHAIN + 1 
then the if-statement above looks wrong, should it be "if (iplb_num > 
MAX_IPLB_CHAIN + 1)" instead?

> +        }
> +
> +        ipl->qipl.num_iplbs = iplb_num - 1;

You could move that into the body of the above if-statement, since otherwise 
the value has been set earlier in this function already.

> +        /* Start at 1 because the IPLB for boot index 0 is not chained */
> +        for (int i = 1; i < iplb_num; i++) {

Just to double-check: Is "i < iplb_num" right?
Or should it be "i <= iplb_num" instead?

BTW, have you successfully tested booting with 8 devices that all have a 
boot index, but only the last one is bootable?

> +            dev_st = get_boot_device(i);
> +            s390_build_iplb(dev_st, &iplb_chain[i - 1]);
> +            iplb_chain[i - 1].flags |= DIAG308_FLAGS_LP_VALID;
> +        }
> +
> +        s390_ipl_map_iplb_chain(iplb_chain);
> +    }
> +
> +    return iplb_num;
> +}

  Thomas



