Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8F4C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvoz8-0006kU-UP; Mon, 17 Aug 2026 00:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoz7-0006kL-7d
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:30:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoz5-0002zA-DX
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:30:04 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLCuXc161726
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BdtAm5c9rFJSBn1kn0vmyGSAssJGY1Yn6VmeZc1wja0=; b=lEtooH+yzkNB7o6r
 WLGAhAU1JT28zR9CetJIZ+vF02oJzwS30sDqABYalhyGQ/dBMmxaO6QOS04iziJn
 UR4yMT3S5Gcb2fRKz6n8TY/x6L7mW6+Ztn6pzfi19TQUUI6Ma6FPZYk537hvSGhN
 TN42bzRzViCacStl5wX8rbMZhqcvemWFHBPLvtBJUPvGSi4aho+6oOIC8sLB2j9N
 KS8w/faKdlDsI8qAWnRr2TiK79BcZ30B2tVf+IzhI3JHZ+iyziC/a/dGsjUUFMRY
 KJDJIn/+5VGCYhK2P3FnCMe1yaZvKyZScuBh1LazD1gEA7Zy1Hbfk1uua7psejC8
 ShE/SQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghk55pf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:30:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9309af14fd7so236102585a.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 21:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786941000; x=1787545800; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BdtAm5c9rFJSBn1kn0vmyGSAssJGY1Yn6VmeZc1wja0=;
 b=ZJ1PcCx9avffBKrhuLGUBs9J6FVjvww1vrlYFWznkohq59v/eOAk0uqYyoQUnuhDSV
 6Rny/ZcTVZ+xbQPsUVGUfQ5J2EbhKMBRlilCZXVu80YHoEbTBzWJiUl011QA54PYozab
 6onPLM4fvtXO3Y+j27LuWDzrZwAuhUTNSTlcypOJkepAdclypu6waWqcxbqIeKKqX35G
 6KsW++pN+qsCGDtmbRm6Vm8XLYs1KWbtHlTl5bZyuV1vZBRWlNKx9yD4o8NhRfOlEhd3
 EymCox/RujhK9FDT+TB9UVnJnnIMBThYFHGwG3Mq3e9H4vj87OPXaKdwPHeBo9aBOVCZ
 Vpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786941000; x=1787545800;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BdtAm5c9rFJSBn1kn0vmyGSAssJGY1Yn6VmeZc1wja0=;
 b=kWk1vXKk8f9J7bf5mI5TzYHP5GOHuKrPbnXZFd4z7Y94dziOBzYqmJlr++v+IS5xnu
 Ol1my8IkWQRERVNGB42eI0AYBcNVTSLxQCbQT4YeQOPJ5+RMhMHZnORhI+4WZujjzaqG
 WODMm9ueqQuFnfq+bs26ViC9XQo7hOcJ/O4PDdVlNF/8v3oYjE+viddOh35rbw3ByIqz
 ffKT95QhC7MHggYv/l+a6sL91ugXmR3nTwrE33fYVXkTLHBizi4RniS0zjIhZdAIGgKH
 7++F8lK9exQSMQvghmN3LowCTYnztsPWGSSTTp/TIiOfzPmAqFBf7/BEizV4fczTwQP+
 1BUA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4tzxJT+2iklaqqVuMskhH5vEgO0UmjhtYFmLlz3jbihISzCXtf5Uo7gir5qOqe01vxRN3r5wHrcRn@nongnu.org
X-Gm-Message-State: AOJu0YwcH520aU2TrqrM8UCLuMG6ZNTI4weoK4LMPX4aSNqNHTqkYh/b
 hmX7yL5/YuJtjdXPw1H6bk9EZJ/3wtf8nkBzoV8XfJ4EC+YagSMSOFsTjxeWjGyuFNQVxOs4izR
 A9FskoxVSYpAseBN8zi7OcncUDkmlwznC1YJlrPL2wC4VjpS03I+I5sYhzg==
X-Gm-Gg: AR+sD125hvWCXvHtSZNczNIEoJAMx2lpgMa4WE6WvCS2M9LqMdv1m0nAVkATArfvjb3
 IxBpWbLYn2Wcqmanl2oQuL2fN6RawjiAS+I9g32a5Hc2VyUeGp4PWy7ps+RtojVkYFeqlVZfAmm
 JEEMjiQVIK6d/NHmLSiq/8J1PZ1jE3l5dsrtv6OcvTzEG9lrzzqAvO2aap8oIJ9zwriowz5Z+UE
 zvCmUTID5FYHybBiEcmvzML2yjKZCUPjr1zZZ95Z6UstZ+Jw3G9FOvmyGJp+6/2VE20v7dgm4aL
 xbdIT6PFs012aylQ9GgEtxbb14oTVHWVnmXvukOAJges3bDqRjpsG6mWRUDddm45UewksFRERb/
 2aZzII5fCPDlKnXwG/f/RG5egc6RojWsfO5s=
X-Received: by 2002:a05:620a:4688:b0:8ee:bae8:2bb8 with SMTP id
 af79cd13be357-936d238d059mr2424248485a.36.1786941000064; 
 Sun, 16 Aug 2026 21:30:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4688:b0:8ee:bae8:2bb8 with SMTP id
 af79cd13be357-936d238d059mr2424245285a.36.1786940999650; 
 Sun, 16 Aug 2026 21:29:59 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b25ad8sm195415895e9.2.2026.08.16.21.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 21:29:58 -0700 (PDT)
Message-ID: <709f1994-e992-45e8-b33f-1a00b943bc50@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 06:29:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] target/hexagon: add main arch-specific
 semihosting operations
Content-Language: en-US
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Kohei Tokunaga <ktokunaga.mail@gmail.com>
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
 <96776c988e48b04a59a146fb62a934389a73a4a2.1784568922.git.matheus.bernardino@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <96776c988e48b04a59a146fb62a934389a73a4a2.1784568922.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMSBTYWx0ZWRfX4Eg+gUZA70dR
 Zm294b4nUYCP/dmIhPZXBvPf5JSMZGw+APRpETPREsJ3e2LeLxvjl+sI8QOT4OjP2E+dNuy34y1
 FOHMsnUUm6TGEebdyn6QVf/8MwgJQO4=
X-Proofpoint-GUID: 078ip32Ice3LTbmZZpgzpjJkKOr-V1OL
X-Authority-Analysis: v=2.4 cv=f+14wuyM c=1 sm=1 tr=0 ts=6a828e48 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=YJH3HQm7HNo5BGMEpUMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMSBTYWx0ZWRfX4p2d0PSk68eo
 U+gCQ44KmH+gQjWRC4NDIgxalEvEeyscy6lB3wAmebNHFTxjU7422N6RgZtgcGmg+yEgijNVvFF
 9fUhfHCpqoiXIyKZpxnsoukxd3vVIQ0g3GEZo3yu6PW+6HsvbCzyP9HG0kN+gw3ZubNdP8nHP2O
 Gs/YAcpLEOMy5rDSjQBG2RWxirO3yCq3oxjHtG6RFqXtHjCXscoSz715vgjEuQqV/ogI2UzXe8f
 QyyO4j2q3pxlY6kEXHmmZWt4PeNCpAlhZF4iZmmAk13IVLzi9h5EeQXE/VJWbxQ2HZMMMepJ6yr
 ZyUuuzR1opbLPrv8E6e1EDcRq2NPavX/aQgXM4SPgYzNFvNjYo8k2hb34jZ71WyLnnwZOjS37yj
 tx0uXuj6loSBMYNyE+O8SMJIyS0wBcQ3xJ8swcOR3UwnYe429LYNBXWwn+sj97NRRONY2m9bXXt
 EG8IHULhr72zaap+2Cg==
X-Proofpoint-ORIG-GUID: 078ip32Ice3LTbmZZpgzpjJkKOr-V1OL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Cc'ing Kohei for WASM

On 20/7/26 19:41, Matheus Tavares Bernardino wrote:
> The Hexagon semihosting ABI extends the arm-compatible set with
> operations like OPEN, WRITECREG, WRITE0, ISTTY, STAT, FSTAT, FTELL,
> SEEK, FTRUNC, ACCESS, and GETCWD. Implement these trap0 handlers so
> that baremetal programs using the standard Hexagon simulator ABI can
> perform file I/O when running on qemu-system-hexagon.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>   include/semihosting/common-semi.h |   1 +
>   semihosting/arm-compat-semi.c     |   2 +-
>   target/hexagon/hexswi.c           | 298 +++++++++++++++++++++++++++++-
>   3 files changed, 299 insertions(+), 2 deletions(-)


> +    case HEX_SYS_STAT:
> +    case HEX_SYS_FSTAT:
> +    {
> +        struct stat st_buf;
> +        uint8_t *st_bufptr = (uint8_t *)&sys_stat;
> +        int rc, err = 0;
> +        char filename[BUFSIZ];
> +        target_ulong physical_filename_addr;
> +        target_ulong statBufferAddr;
> +        hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
> +
> +        if (what_swi == HEX_SYS_STAT) {
> +            int i = 0;
> +            do {
> +                hexagon_read_memory(env, physical_filename_addr + i, 1,
> +                                    &filename[i], retaddr);
> +                i++;
> +            } while ((i < BUFSIZ) && filename[i - 1]);
> +            rc = stat(filename, &st_buf);
> +            err = errno;
> +        } else {
> +            int fd = physical_filename_addr;
> +            GuestFD *gf = get_guestfd(fd);
> +            if (!gf || gf->type != GuestFDHost) {
> +                qemu_log_mask(LOG_UNIMP,
> +                              "fstat semihosting only implemented"
> +                              " for native mode\n");
> +                g_assert_not_reached();
> +            }
> +            rc = fstat(gf->hostfd, &st_buf);
> +            err = errno;
> +        }
> +        if (rc == 0) {
> +            sys_stat.dev   = st_buf.st_dev;
> +            sys_stat.ino   = st_buf.st_ino;
> +            sys_stat.mode  = st_buf.st_mode;
> +            sys_stat.nlink = (uint32_t) st_buf.st_nlink;
> +            sys_stat.rdev  = st_buf.st_rdev;
> +            sys_stat.size  = (uint32_t) st_buf.st_size;
> +#if defined(__linux__)
> +            sys_stat.atime = (uint32_t) st_buf.st_atim.tv_sec;
> +            sys_stat.mtime = (uint32_t) st_buf.st_mtim.tv_sec;
> +            sys_stat.ctime = (uint32_t) st_buf.st_ctim.tv_sec;
> +#elif defined(_WIN32)
> +            sys_stat.atime = st_buf.st_atime;
> +            sys_stat.mtime = st_buf.st_mtime;
> +            sys_stat.ctime = st_buf.st_ctime;
> +#endif

This #if/elif seems bogus in that various hosts are not covered,
in particular *BSD and WASM. We could use #else #error to catch
them, or better implement OS-specific [f]stat() helpers (see
include/system/os-*.h).

> +        }
> +        hexagon_read_memory(env, swi_info + 4, 4, &statBufferAddr, retaddr);
> +
> +        for (int i = 0; i < sizeof(sys_stat); i++) {
> +            hexagon_write_memory(env, statBufferAddr + i, 1, st_bufptr[i],
> +                                 retaddr);
> +        }
> +        common_semi_cb(cs, rc, rc == 0 ? 0 : err);
> +    }
> +    break;


