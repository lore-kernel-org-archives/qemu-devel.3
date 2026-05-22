Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB8FCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZI5-0000fB-QD; Fri, 22 May 2026 19:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZI1-0000eb-UH
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:28:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZHz-0004ZB-GM
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:28:25 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MH6hPn1800728
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EDCR/dmMvIjV4zhUFkWSL+aCqA1RJLCEWlKQtj/6XQA=; b=LLvbdQBIx6pUV/WJ
 vGT/FsSjzzvuAlZwfDCWgfr3Jhr7AaqvkLYps8m3fjk1YWoVqifkg3DB3x0PE8oq
 1zHHGPu4lWlcp4ZcvipGWX2YyaadIuCXBefMta8KZ9+Ui4SIidkJxnisOiaCnYPC
 vPYLf/PSK10J+9zhdW6w/BTCFO87nLMFTOeC8uAzQDvcnEdQadz0GcaIviqgMR/Q
 3rBVfisjdbTPAAoOApiy8rAJUT4JDKmi57OfytdD8NZUInKk2NPpyRyBer1H6QJK
 g4HYBpg+XM7om4t4jOBRqYHms0pwIHhp6Risj9sx+MBJFz0uxhl0aQeaKdFnU/pk
 AvlQEA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean9g2pkk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:28:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304448ab58cso5751149eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779492500; x=1780097300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EDCR/dmMvIjV4zhUFkWSL+aCqA1RJLCEWlKQtj/6XQA=;
 b=GTYw5mHaerZOVxtfmzHLTnLdUS69aBn1Fd1UkunwxuF2Gtzll0fgImHLvIIcoHkrag
 gNHIGJFLWPC+iBs76BNaGe1NaYi69cdgX8nf35lXY7RDpwfEnB6L9DUqUC1PYB6BLGVT
 MMQaFBUpszjV6a3nKEJGU4ihkhMZPcsmCs85fLafJZ+EeSBczkIGblNSLIJaCbnH+Scr
 quifhSrzuRllTMq1czAbweOPF5/AIivfw/gVSTvals5grD2566lF2EiMIVUzBGyoVTQw
 LppjMAwktoMDO8E+R1b++Zg2YJUOeH4SJm2Txz+VblTrnGgP3X22oqoO7/2KfFIpkJfp
 IiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779492500; x=1780097300;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EDCR/dmMvIjV4zhUFkWSL+aCqA1RJLCEWlKQtj/6XQA=;
 b=JGEbc+Lt7Afkr5QNwI355qONaFqExHlsPAusFiP+B0Z3y/y6qPpDwWcp1mmjnnZNrh
 rj5v9oA140gpRmOL6h+x3JZrbS4VFqh8E9X4zA2m3JYr6Ocs6Lcnd7rNDPHvbLdGFdoo
 MVpY16TIGZ11vEPZx/5kskFs4q3umkhKDKXTkX9t5pdwzODIDLmBuD8K+LRTL6rBT6Qm
 aIoAhpsbW6c3k8WC27OwxeeV+61iDMnNDNg1QLdnIq6npQ/MsLAetbXz+3NnvsS9uyZU
 WFfhMSGuobeAdoUsDnxFOEFgWewDZWsUo91PYDOREVTHy6RUZlmD4KPTLL2VH7zxuMcW
 GLeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ljUBqLpkkDBI7I4d9hn9rN/xQJH/Mq3siVT/Vntxtl18rZs4629+/z6CkHfBY++zbleq7stQJqIcb@nongnu.org
X-Gm-Message-State: AOJu0YyMsOo/EykDu1XNZAqOeF/uO0WivRxznrwQm6UExNvKy1PtKDir
 bh6jGDyCcTihEHGVY6oXld5zRPUboZQRYd9ZISIiDeDFpzWqBnSm1uWfBqWHsmQMDyyv4WjniEn
 AhPSerlKBGH8wdn8vJaYEE5fxxRDiV7D47UtZyrE0FmyGUvSWMP9XcU8knO4fH8X03N9f
X-Gm-Gg: Acq92OGODpDROAUDBcFVbWeasX/mb5lPvdNXPk3zH2B4ece/fUHVLBIgOeiR7fXV9lK
 6oxACxPmrWDZA/T9NsUmEC/0j9MtwbSG8swWnTka5nbudRdCcQYZ2275Eaw+DF4IveZpaaiA05S
 lG2dMB8xEO9P2lsTQm2hGMIx6wLeZyQ/glw70jklKwoCKm+MfCEhprw9QngGMwNB5frKeWwz18g
 198kmJjEdBbC+tL4Pl5q8sdLPF1HEUUt7BOWa+HGmkT7ED2/D/ZSek55Tm8nauY+5OdCR3Z8qLV
 nozH4XgAEb0KhvN4UrC6MpHytRFMbDnNzElKsiJKPlKXjS6ovVQsST2xs4j4C21J9G4N2SJo1iG
 EcDxrPnbb8SNM+6yoduI9ZxecbQp1bfZM1v/JQ+U2SIHC7/03ri4qXJeyqBIZpDSeExmEbZMnf7
 9DsDLRZc05lSmlxA==
X-Received: by 2002:a05:7300:cd99:b0:304:188d:d0be with SMTP id
 5a478bee46e88-30449156f8cmr2630316eec.16.1779492500033; 
 Fri, 22 May 2026 16:28:20 -0700 (PDT)
X-Received: by 2002:a05:7300:cd99:b0:304:188d:d0be with SMTP id
 5a478bee46e88-30449156f8cmr2630302eec.16.1779492499387; 
 Fri, 22 May 2026 16:28:19 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef3273sm2990718eec.2.2026.05.22.16.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:28:18 -0700 (PDT)
Message-ID: <05842e0f-5c9b-4820-8c43-78ca3d596e0c@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:28:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/37] bsd-user: Add do_bsd_getsockopt
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-13-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-13-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 36yTfSJ7cYGLan3UYll2t6EzUotQMvPn
X-Authority-Analysis: v=2.4 cv=B/qJFutM c=1 sm=1 tr=0 ts=6a10e695 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=6I5d2MoRAAAA:8 a=pGLkceISAAAA:8 a=7Qk2ozbKAAAA:8 a=8LDr2ni_9x3a-UP6CwEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: 36yTfSJ7cYGLan3UYll2t6EzUotQMvPn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzNCBTYWx0ZWRfX4SfOG14qTNO+
 KLRN8914QwphhWE8CPbK8wdscMNIhNKJ+dsI7gVPBVPxgAb5lOpI3Ti/vpy1dI9JC8DaMt23I16
 5cmf/+eF/cgr2UHsanvnZ+1HfPQ3dzCpTbA3mVKpUkDZbytLJJi+Ts731S/Je+qR6O5iV6GJFeP
 eyxlcpglu1P0aSXR9Zpd4iaamGytzREV7VJjxQvuYAZK767lBCqgzrjAZbXUnx69Xl1PEFD3R0m
 KfzyO5P7zO2eJM7wYccr0R209EzjNi5umFk0YzqjsrANXQgUJ/Zo62bFvrmpAAACeskEjNArcAm
 O/8txOEYPPY5B4pOG/xs7NhbyGfXaanbCbv2MZnB15SwB1f4Lrv6GwW+vDNR6yLCrGQJvRS4HbV
 SjyxsWQtv+MAEK/f81is04be0zmHvFZX0nf0LxbauiMmOCnZ/RklNC+XsOapaZn1AOzWq+D6hv8
 MuXH5guzcjpPkNvlycw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220234
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
> Add the getsockopt(2) implementation handling SOL_SOCKET, IPPROTO_TCP,
> IPPROTO_IP, and IPPROTO_IPV6 levels with proper target-to-host option
> name translation.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-socket.h | 284 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 284 insertions(+)
> 
> diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
> index 897a1f4d2f..f8521780c1 100644
> --- a/bsd-user/freebsd/os-socket.h
> +++ b/bsd-user/freebsd/os-socket.h
> @@ -399,5 +399,289 @@ unimplemented:
>      return ret;
>  }
>  
> +/* getsockopt(2) */
> +static inline abi_long do_bsd_getsockopt(int sockfd, int level, int optname,
> +        abi_ulong optval_addr, abi_ulong optlen)
> +{
> +    abi_long ret;
> +    int len, val;
> +    socklen_t lv;
> +    void *p;
> +
> +    switch (level) {
> +    case TARGET_SOL_SOCKET:
> +        level = SOL_SOCKET;
> +        switch (optname) {
> +
> +        /* These don't just return a single integer */
> +        case TARGET_SO_LINGER:
> +        case TARGET_SO_RCVTIMEO:
> +        case TARGET_SO_SNDTIMEO:
> +        case TARGET_SO_ACCEPTFILTER:
> +            goto unimplemented;
> +
> +        /* Options with 'int' argument.  */
> +        case TARGET_SO_DEBUG:
> +            optname = SO_DEBUG;
> +            goto int_case;
> +
> +        case TARGET_SO_REUSEADDR:
> +            optname = SO_REUSEADDR;
> +            goto int_case;
> +
> +        case TARGET_SO_REUSEPORT:
> +            optname = SO_REUSEPORT;
> +            goto int_case;
> +
> +        case TARGET_SO_TYPE:
> +            optname = SO_TYPE;
> +            goto int_case;
> +
> +        case TARGET_SO_ERROR:
> +            optname = SO_ERROR;
> +            goto int_case;
> +
> +        case TARGET_SO_DONTROUTE:
> +            optname = SO_DONTROUTE;
> +            goto int_case;
> +
> +        case TARGET_SO_BROADCAST:
> +            optname = SO_BROADCAST;
> +            goto int_case;
> +
> +        case TARGET_SO_SNDBUF:
> +            optname = SO_SNDBUF;
> +            goto int_case;
> +
> +        case TARGET_SO_RCVBUF:
> +            optname = SO_RCVBUF;
> +            goto int_case;
> +
> +        case TARGET_SO_KEEPALIVE:
> +            optname = SO_KEEPALIVE;
> +            goto int_case;
> +
> +        case TARGET_SO_OOBINLINE:
> +            optname = SO_OOBINLINE;
> +            goto int_case;
> +
> +        case TARGET_SO_TIMESTAMP:
> +            optname = SO_TIMESTAMP;
> +            goto int_case;
> +
> +        case TARGET_SO_RCVLOWAT:
> +            optname = SO_RCVLOWAT;
> +            goto int_case;
> +
> +        case TARGET_SO_LISTENINCQLEN:
> +            optname = SO_LISTENINCQLEN;
> +            goto int_case;
> +

This duplicates what there is in previous patch.
We should add a target_to_host_sockopt that takes care of this.

> +        default:
> +int_case:
> +            if (get_user_u32(len, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            if (len < 0) {
> +                return -TARGET_EINVAL;
> +            }
> +            lv = sizeof(lv);
> +            ret = get_errno(getsockopt(sockfd, level, optname, &val, &lv));
> +            if (ret < 0) {
> +                return ret;
> +            }
> +            if (len > lv) {
> +                len = lv;
> +            }
> +            if (len == 4) {
> +                if (put_user_u32(val, optval_addr)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            } else {
> +                if (put_user_u8(val, optval_addr)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            }
> +            if (put_user_u32(len, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            break;
> +
> +        }
> +        break;
> +
> +    case IPPROTO_TCP:
> +        /* TCP options all take an 'int' value. */
> +        goto int_case;
> +
> +    case IPPROTO_IP:
> +        switch (optname) {
> +        case IP_OPTIONS:
> +            if (get_user_u32(len, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            lv = (socklen_t)len;
> +            p = lock_user(VERIFY_WRITE, optval_addr, len, 0);
> +            if (p == NULL) {
> +                return -TARGET_EFAULT;
> +            }
> +            ret = get_errno(getsockopt(sockfd, level, optname, p, &lv));
> +            unlock_user(p, optval_addr, len);
> +            if (put_user_u32(lv, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            break;
> +        case IP_HDRINCL:
> +        case IP_TOS:
> +        case IP_TTL:
> +        case IP_RECVOPTS:
> +        case IP_RECVRETOPTS:
> +        case IP_RECVDSTADDR:
> +
> +        case IP_RETOPTS:
> +#if defined(IP_RECVTOS)
> +        case IP_RECVTOS:
> +#endif
> +        case IP_MULTICAST_TTL:
> +        case IP_MULTICAST_LOOP:
> +        case IP_PORTRANGE:
> +        case IP_IPSEC_POLICY:
> +        case IP_ONESBCAST:
> +        case IP_BINDANY:
> +            if (get_user_u32(len, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            if (len < 0) {
> +                return -TARGET_EINVAL;
> +            }
> +            lv = sizeof(lv);
> +            ret = get_errno(getsockopt(sockfd, level, optname,
> +                &val, &lv));
> +            if (ret < 0) {
> +                return ret;
> +            }
> +            if (len < sizeof(int) && len > 0 && val >= 0 &&
> +                val < 255) {
> +                len = 1;
> +                if (put_user_u32(len, optlen) ||
> +                        put_user_u8(val, optval_addr)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            } else {
> +                if (len > sizeof(int)) {
> +                    len = sizeof(int);
> +                }
> +                if (put_user_u32(len, optlen) ||
> +                        put_user_u32(val, optval_addr)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            }
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
> +            if (get_user_u32(len, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            if (len < 0) {
> +                return -TARGET_EINVAL;
> +            }
> +            lv = sizeof(lv);
> +            ret = get_errno(getsockopt(sockfd, level, optname,
> +                &val, &lv));
> +            if (ret < 0) {
> +                return ret;
> +            }
> +            if (len < sizeof(int) && len > 0 && val >= 0 &&
> +                val < 255) {
> +                len = 1;
> +                if (put_user_u32(len, optlen) ||
> +                        put_user_u8(val, optval_addr)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            } else {
> +                if (len > sizeof(int)) {
> +                    len = sizeof(int);
> +                }
> +                if (put_user_u32(len, optlen) ||
> +                        put_user_u32(val, optval_addr)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            }
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
> +    default:
> +unimplemented:
> +        gemu_log("getsockopt level=%d optname=%d not yet supported\n",
> +            level, optname);
> +        ret = -TARGET_EOPNOTSUPP;
> +        break;
> +    }
> +    return ret;
> +}
> +
>  
>  #endif /* BSD_USER_FREEBSD_OS_SOCKET_H */
> 


