Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517C6CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZIX-0000p8-Uo; Fri, 22 May 2026 19:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZIW-0000ol-Eh
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:28:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZIU-0004ix-Aj
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:28:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MIukqv1958624
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A49bGsblRbamoIm8IFAlkMYUVZzY8g4pSCq0qBj42nQ=; b=FnP/aYomP6aiHaaM
 Yv6cpKHrfrPvzF9r/VP7gSMXSlz4TSEMlNPLVNIZMY/0SsoKpjUfdONmvILpTMFM
 wWFhJjsq16RJlsfcPaD59CvcRQksibvMUFPdRNPSuvSbzpTDYAb7PJDPtjXLhamV
 dlq/wna447f9kmqgkyQI2cJfQmpbMT/RY0dNxD4sJhU8HEaUF31nLA4ErYtYBqkS
 dhvODOl984hT2w/bat2ow8oGqVZpmHb+/1+QgZvFf/MQRuVTK49kZIQcwzVjZI1x
 /lbA0JU+GZkJLB8OEwkRGJmIH5ND1lETu6cVKMTPumQOAz5O8BjqZB15KyJtB3oM
 iEJRaQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eahxeunpf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:28:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30457ff05b8so977161eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779492532; x=1780097332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A49bGsblRbamoIm8IFAlkMYUVZzY8g4pSCq0qBj42nQ=;
 b=fvvl7efgDAaRLJq3+9xAn++c3YC5Jgn+Ev7gsSM2xYHkniCDT6WGF+aXcyXhL363h5
 iNuha9lEZGZanorO9Sc+1GvR29i3NdVO3D5OIJ9uBpwa0eSyGExhBnjiNSXGP4wQA+bt
 cxEmNc8sp4hC6iGJJNF48XYvZF9+MmXt3jPsHB/yHL+bj1cbwENMDqwxv2wu97KLwNCk
 SHbLMHLlthittPMV2vAXZ8aoqYZQEuCfdcShCgXIFwcz4sGJSSltGuKbzc64t+vRmryX
 svRAHSglf1GB8iyTXA7Q71rfNFOw7F7Kg4SS+DLr+HargyzPjV5jbT5w13tnw6GdIfGS
 TgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779492532; x=1780097332;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A49bGsblRbamoIm8IFAlkMYUVZzY8g4pSCq0qBj42nQ=;
 b=I0duZAeSd6FlS/AacCdx0kfscE0siaWaSWJGsBE6hUAERZDIbMdmG4mgs5tzMjMV2+
 8Mi6IpRuk6NM7vTS1e4rvru3oIbbKeOjnzl/0YFRDexvNuPtgzpZphHIK7SsPZYxwoII
 s/i1fHNl1WYJCs7I9No6+qpRPcO+weoPKlOsusDRUhANrwVrcgAjM+ByfPiSmcZp7vir
 9EXGa4UBn7icAHCz9g4aZs0VrECjJYV7lXtpSSl7bxJFFYsV7DBrQ/FxPS4gtAHDg1hJ
 /dgxACopzlbmRpAUxqc5qB5poXqVOrTqbmuhRo6WMtGzIDyZQO7ZsjwfmSV2XDFT+uqz
 NQ3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jL2Q+KjvHLtX8p4UF/0BGIT+4BITyNRv0lM8PQUsJ2RpQAWlTKC3Aq1Z3o33eNCDbF2PeW/BO+AuD@nongnu.org
X-Gm-Message-State: AOJu0YxiZOMorGp6JSEffKVvifE3oo35o8Ua7xPfLzAxxTAFBfq6FNvS
 OyRy3ZW3nmizCbZjunsEqTcDZhx2pciYCNBMi0FmQkRkiKa49jP5HHB7F3FBm/JfYT1J4xFIRLe
 LiYT7UgTAc5xqr48DFMELD0K5KR9CkYUi4gsm06VsiNjisBs2ulaCWUe2uA==
X-Gm-Gg: Acq92OFt4Z/j1gf7WL7sz1H3D77+XjRyHjEYPpoMmnoQi86ZrmowI6O6KazOtm3DdyN
 3HSbhXfzk6r5FZvA5rgKJmltBfD3XvutArAbncBL5NWaD5ujGqqGh2hn1XRxgKvws94gmX8ylmO
 s9wNB9Z2Z8UA10kHr/qZy4xUUt5t/r3Qt5X3K8jKg7fWILOq+FuypUtBKG1RLCYg3XpHWwQVW2J
 fNAlN/RGmORwRXC81LYAKocqT2tQC/mQ0j2dC3ZsXdCDhY6aATKBpxbbwA4fUqJDz3SejNOdAeu
 T1B9N88lXcaaR2C6QFZgh7H8ClgHQqK81ZJsh39hgQCcQerJ9mTmS0cAJgUz6trzPq0uzymP7Sx
 G3sKPWikuAXornfT9ScTw2K4tuczu+Kx9hLF8/rkprRvDbgC1ZlN83+H+cnLR3XkCTm9yNsMBud
 K5vjFRvOvjDaa04bK2quEhfbE5
X-Received: by 2002:a05:7300:2313:b0:2f5:285c:4374 with SMTP id
 5a478bee46e88-30449119476mr2956149eec.35.1779492531677; 
 Fri, 22 May 2026 16:28:51 -0700 (PDT)
X-Received: by 2002:a05:7300:2313:b0:2f5:285c:4374 with SMTP id
 5a478bee46e88-30449119476mr2956134eec.35.1779492531089; 
 Fri, 22 May 2026 16:28:51 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef5492sm2088613eec.6.2026.05.22.16.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:28:50 -0700 (PDT)
Message-ID: <e5954fc8-b571-4612-bb10-fc9b592bbc84@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:28:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/37] bsd-user: Add do_bsd_setsockopt and socket
 option definitions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>,
 Jessica Clarke <jrtc27@jrtc27.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-12-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-12-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzNCBTYWx0ZWRfX7PkJrTNsnQh4
 Kqjv8KbXFvYNnraiPTPHLDL+ws+7ZmM0179rHUqfXsbxBf5s4kpJCq8/odGZ9rgNGRZowySX6vb
 iA9dQJaqtZqASOtFJ+s9rkP/bwZgPEjUs5GlHZVzsW53xDJOWfH0X7vXEdij2IQ+6eTbe9chwYj
 4NyeyNRQ+5xnvvzPK7756bKz9gm7EmcezA+YUe/EOKAcyBPMtbwS5kSqrqNh+skbqbkyXA/z/mq
 NG6yCpiU4KPi3EA+8qoo228Jifk32xthjUi+aNGB3Ppdq6Qh6xeZiCCyPfrsuuJp3ss1Vx3E/6o
 pJU0Kv/qxY0Q9J2vx7YhDNh76tKyKob0Z04H9r9AJHKfFDnav+9AyTf0QseD+0Q9FzHi8z3YMmS
 dSrNo22FviJfPb7HQm3FQF3A8LDa/A6hdZd763IjX9sS6bfowfnoGA/rgdBbjwMgiyLi1Vhl0Pj
 PlrnrKULBI3JP9mABuw==
X-Proofpoint-GUID: rf3pbiXvxQaTSxHGIND-y5cR1QbAcRBF
X-Proofpoint-ORIG-GUID: rf3pbiXvxQaTSxHGIND-y5cR1QbAcRBF
X-Authority-Analysis: v=2.4 cv=ar2CzyZV c=1 sm=1 tr=0 ts=6a10e6b4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=6I5d2MoRAAAA:8 a=pGLkceISAAAA:8 a=j6bprNooAAAA:8 a=7Qk2ozbKAAAA:8
 a=aE6H0DlV6QM6vzBc_z8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=fS_Hu1hw59wj44055X5l:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220234
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Add the setsockopt(2) implementation handling IPPROTO_TCP, IPPROTO_IP,
> IPPROTO_IPV6, and SOL_SOCKET levels. Also add the TARGET_SO_* socket
> option definitions and TARGET_SOL_SOCKET to syscall_defs.h.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-socket.h | 261 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 261 insertions(+)
> 
> diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
> index 279157dd05..897a1f4d2f 100644
> --- a/bsd-user/freebsd/os-socket.h
> +++ b/bsd-user/freebsd/os-socket.h
> @@ -138,5 +138,266 @@ static abi_long do_sendrecvmsg(int fd, abi_ulong target_msg,
>      return ret;
>  }
>  
> +/* setsockopt(2) */
> +static inline abi_long do_bsd_setsockopt(int sockfd, int level, int optname,
> +        abi_ulong optval_addr, socklen_t optlen)
> +{
> +    abi_long ret;
> +    int val;
> +    struct ip_mreqn *ip_mreq;
> +    void *p;
> +
> +    switch (level) {
> +    case IPPROTO_TCP:
> +        /* TCP options all take an 'int' value. */
> +        if (optlen < sizeof(uint32_t)) {
> +            return -TARGET_EINVAL;
> +        }
> +        if (get_user_u32(val, optval_addr)) {
> +            return -TARGET_EFAULT;
> +        }
> +        ret = get_errno(setsockopt(sockfd, level, optname, &val, sizeof(val)));
> +        break;
> +
> +    case IPPROTO_IP:
> +        switch (optname) {
> +        case IP_OPTIONS:
> +            p = lock_user(VERIFY_READ, optval_addr, optlen, 1);
> +            if (p == NULL) {
> +                return -TARGET_EFAULT;
> +            }
> +            ret = get_errno(setsockopt(sockfd, level, optname, p, optlen));
> +            unlock_user(p, optval_addr, 0);
> +            break;
> +        case IP_HDRINCL:/* int; header is included with data */
> +        case IP_TOS:    /* int; IP type of service and preced. */
> +        case IP_TTL:    /* int; IP time to live */
> +        case IP_RECVOPTS: /* bool; receive all IP opts w/dgram */
> +        case IP_RECVRETOPTS: /* bool; receive IP opts for response */
> +        case IP_RECVDSTADDR: /* bool; receive IP dst addr w/dgram */
> +        case IP_MULTICAST_IF:/* u_char; set/get IP multicast i/f  */
> +        case IP_MULTICAST_TTL:/* u_char; set/get IP multicast ttl */
> +        case IP_MULTICAST_LOOP:/*u_char;set/get IP multicast loopback */
> +        case IP_PORTRANGE: /* int; range to choose for unspec port */
> +        case IP_RECVIF: /* bool; receive reception if w/dgram */
> +        case IP_IPSEC_POLICY:   /* int; set/get security policy */
> +        case IP_RECVTTL: /* bool; receive reception TTL w/dgram */
> +            val = 0;
> +            if (optlen >= sizeof(uint32_t)) {
> +                if (get_user_u32(val, optval_addr)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            } else if (optlen >= 1) {
> +                if (get_user_u8(val, optval_addr)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            }
> +            ret = get_errno(setsockopt(sockfd, level, optname, &val,
> +                        sizeof(val)));
> +            break;
> +
> +        case IP_ADD_MEMBERSHIP: /*ip_mreq; add an IP group membership */
> +        case IP_DROP_MEMBERSHIP:/*ip_mreq; drop an IP group membership*/
> +            if (optlen < sizeof(struct target_ip_mreq) ||
> +                    optlen > sizeof(struct target_ip_mreqn)) {
> +                return -TARGET_EINVAL;
> +            }
> +            ip_mreq = (struct ip_mreqn *) alloca(optlen);
> +            ret = target_to_host_ip_mreq(ip_mreq, optval_addr, optlen);
> +            if (is_error(ret)) {
> +                return -TARGET_EFAULT;
> +            }
> +            ret = get_errno(setsockopt(sockfd, level, optname, ip_mreq,
> +                        optlen));
> +            break;
> +
> +        default:
> +            goto unimplemented;
> +        }
> +        break;
> +
> +    case IPPROTO_IPV6:
> +        switch (optname) {
> +        case IPV6_UNICAST_HOPS:     /* int; IP6 hops */
> +        case IPV6_MULTICAST_IF:     /* u_int; set/get IP6 multicast i/f  */
> +        case IPV6_MULTICAST_HOPS:   /* int; set/get IP6 multicast hops */
> +        case IPV6_MULTICAST_LOOP:   /* u_int; set/get IP6 multicast loopback */
> +        case IPV6_PORTRANGE:        /* int; range to choose for unspec port */
> +        case IPV6_CHECKSUM:         /* int; checksum offset for raw socket */
> +        case IPV6_V6ONLY:           /* bool; make AF_INET6 sockets v6 only */
> +        case IPV6_RECVPKTINFO:      /* bool; recv if, dst addr */
> +        case IPV6_RECVHOPLIMIT:     /* bool; recv hop limit */
> +        case IPV6_RECVRTHDR:        /* bool; recv routing header */
> +        case IPV6_RECVHOPOPTS:      /* bool; recv hop-by-hop option */
> +        case IPV6_RECVDSTOPTS:      /* bool; recv dst option after rthdr */
> +        case IPV6_USE_MIN_MTU:      /* bool; send packets at the minimum MTU */
> +        case IPV6_RECVPATHMTU:      /* bool; notify an according MTU */
> +        case IPV6_HOPLIMIT:         /* int; send hop limit */
> +        case IPV6_RECVTCLASS:       /* bool; recv traffic class values */
> +        case IPV6_AUTOFLOWLABEL:    /* bool; attach flowlabel automagically */
> +        case IPV6_TCLASS:           /* int; send traffic class value */
> +        case IPV6_DONTFRAG:         /* bool; disable IPv6 fragmentation */
> +        case IPV6_PREFER_TEMPADDR:  /* int; prefer temporary addresses */
> +        case IPV6_BINDANY:          /* bool: allow bind to any address */
> +#ifdef IPV6_BINDMULTI
> +        case IPV6_BINDMULTI:        /* bool; allow multibind to same addr/port*/
> +#endif /* IPV6_BINDMULTI */
> +#ifdef IPV6_RSS_LISTEN_BUCKET
> +        case IPV6_RSS_LISTEN_BUCKET: /* int; set RSS listen bucket */
> +#endif /* IPV6_RSS_LISTEN_BUCKET */
> +#ifdef IPV6_FLOWID
> +        case IPV6_FLOWID:           /* int; flowid of given socket */
> +#endif /* IPV6_FLOWID */
> +#ifdef IPV6_FLOWTYPE
> +        case IPV6_FLOWTYPE:         /* int; flowtype of given socket */
> +#endif /* IPV6_FLOWTYPE */
> +#ifdef IPV6_RSSBUCKETID
> +        case IPV6_RSSBUCKETID:      /* int; RSS bucket ID of given socket */
> +#endif /* IPV6_RSSBUCKETID */
> +            val = 0;
> +            if (optlen >= sizeof(uint32_t)) {
> +                if (get_user_u32(val, optval_addr)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            } else if (optlen >= 1) {
> +                if (get_user_u8(val, optval_addr)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            }
> +            ret = get_errno(setsockopt(sockfd, level, optname, &val,
> +                        sizeof(val)));
> +            break;
> +
> +        case IPV6_JOIN_GROUP:   /* ipv6_mreq; join a group membership */
> +        case IPV6_LEAVE_GROUP:  /* ipv6_mreq; leave a group membership */
> +        case ICMP6_FILTER:      /* icmp6_filter; icmp6 filter */
> +        case IPV6_IPSEC_POLICY: /* struct; get/set security policy */
> +        case IPV6_FW_ADD:       /* add a firewall rule to chain */
> +        case IPV6_FW_DEL:       /* delete a firewall rule from chain */
> +        case IPV6_FW_FLUSH:     /* flush firewall rule chain */
> +        case IPV6_FW_ZERO:      /* clear single/all firewall counter(s) */
> +        case IPV6_FW_GET:       /* get entire firewall rule chain */
> +        case IPV6_RTHDRDSTOPTS: /* ip6_dest; send dst option before rthdr */
> +        case IPV6_PATHMTU:      /* mtuinfo; get the current path MTU */
> +        case IPV6_PKTINFO:      /* in6_pktinfo; send if, src addr */
> +        case IPV6_NEXTHOP:      /* sockaddr; next hop addr */
> +        case IPV6_HOPOPTS:      /* ip6_hbh; send hop-by-hop option */
> +        case IPV6_DSTOPTS:      /* ip6_dest; send dst option befor rthdr */
> +        case IPV6_RTHDR:        /* ip6_rthdr; send routing header */
> +        case IPV6_MSFILTER:     /* struct __msfilterreq; */
> +        default:
> +            goto unimplemented;
> +        }
> +        break;
> +
> +    case TARGET_SOL_SOCKET:
> +        switch (optname) {
> +        /* Options with 'int' argument.  */
> +        case TARGET_SO_DEBUG:
> +            optname = SO_DEBUG;
> +            break;
> +
> +        case TARGET_SO_REUSEADDR:
> +            optname = SO_REUSEADDR;
> +            break;
> +
> +        case TARGET_SO_REUSEPORT:
> +            optname = SO_REUSEPORT;
> +            break;
> +
> +        case TARGET_SO_KEEPALIVE:
> +            optname = SO_KEEPALIVE;
> +            break;
> +
> +        case TARGET_SO_DONTROUTE:
> +            optname = SO_DONTROUTE;
> +            break;
> +
> +        case TARGET_SO_LINGER:
> +            optname = SO_LINGER;
> +            break;
> +
> +        case TARGET_SO_BROADCAST:
> +            optname = SO_BROADCAST;
> +            break;
> +
> +        case TARGET_SO_OOBINLINE:
> +            optname = SO_OOBINLINE;
> +            break;
> +
> +        case TARGET_SO_SNDBUF:
> +            optname = SO_SNDBUF;
> +            break;
> +
> +        case TARGET_SO_RCVBUF:
> +            optname = SO_RCVBUF;
> +            break;
> +
> +        case TARGET_SO_SNDLOWAT:
> +            optname = SO_RCVLOWAT;
> +            break;
> +
> +        case TARGET_SO_RCVLOWAT:
> +            optname = SO_RCVLOWAT;
> +            break;
> +
> +        case TARGET_SO_SNDTIMEO:
> +            optname = SO_SNDTIMEO;
> +            break;
> +
> +        case TARGET_SO_RCVTIMEO:
> +            optname = SO_RCVTIMEO;
> +            break;
> +
> +        case TARGET_SO_ACCEPTFILTER:
> +            goto unimplemented;
> +
> +        case TARGET_SO_NOSIGPIPE:
> +            optname = SO_NOSIGPIPE;
> +            break;
> +
> +        case TARGET_SO_TIMESTAMP:
> +            optname = SO_TIMESTAMP;
> +            break;
> +
> +        case TARGET_SO_BINTIME:
> +            optname = SO_BINTIME;
> +            break;
> +
> +        case TARGET_SO_ERROR:
> +            optname = SO_ERROR;
> +            break;
> +
> +        case TARGET_SO_SETFIB:
> +            optname = SO_SETFIB;
> +            break;
> +
> +#ifdef SO_USER_COOKIE
> +        case TARGET_SO_USER_COOKIE:
> +            optname = SO_USER_COOKIE;
> +            break;
> +#endif
> +        default:
> +            goto unimplemented;
> +        }
> +        if (optlen < sizeof(uint32_t)) {
> +            return -TARGET_EINVAL;
> +        }
> +        if (get_user_u32(val, optval_addr)) {
> +            return -TARGET_EFAULT;
> +        }
> +        ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname, &val,
> +                    sizeof(val)));
> +        break;
> +    default:
> +unimplemented:
> +    gemu_log("Unsupported setsockopt level=%d optname=%d\n",
> +        level, optname);
> +    ret = -TARGET_ENOPROTOOPT;
> +    }
> +
> +    return ret;
> +}
> +
>  
>  #endif /* BSD_USER_FREEBSD_OS_SOCKET_H */
> 

See comment on next patch to solve duplicate for translating sockopt.

