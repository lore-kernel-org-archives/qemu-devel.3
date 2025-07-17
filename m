Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C737C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 06:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIRQ-00064d-Lr; Thu, 17 Jul 2025 02:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1ucIQD-0003Yl-57; Thu, 17 Jul 2025 02:48:50 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1ucIQB-0002Uj-3l; Thu, 17 Jul 2025 02:48:48 -0400
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MsqIi-1urcJb1rGS-00wGO0; Thu, 17 Jul 2025 08:48:39 +0200
Message-ID: <e1fe443a-b715-41e8-a292-98449468e321@vivier.eu>
Date: Thu, 17 Jul 2025 08:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu 1/2] Don't reverse bFLT endianess when not needed
To: ~wojtekka <wojtekka@toxygen.net>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <175270306503.19369.144677794735042916-1@git.sr.ht>
Content-Language: en-US, fr-FR
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <175270306503.19369.144677794735042916-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rejVcnrlK+88EX8UJuo6xZivVERj+TEkT/49biszroQXcK1KwAb
 e6+cjB1t/I2lofmkbJjwT/FhkmFp205Aqo2tfga1+gW9jalZMRYcpRwBCWjfpHVorOGgjZ4
 xcTl8HQImQLu9l3XoVB8YZMv4Jh0w/YMfRiTz1oVVN7lBDTzy2A/7rltIFII1IMgoHL1p+s
 xrNu5cIsqmakYblTN8UOg==
UI-OutboundReport: notjunk:1;M01:P0:59CfV1iYz5E=;SlJDWzIdW7r3fbTjes9lk1q0PG8
 gEdN1LyoKB6lsnl9ZSt5mco8oZSHiQ1km2L9hMAtZpgQ3ONX5Ukw4eu2VFfoW62UufZk/ACG8
 HJz/LE/zlRR1r5RhFjt49pHVrzV1iWpEEW04N5MwLyvdlY0XAYR00WG/JNZD5d2aUBfiDG0JO
 jpdDsyBjbSMBiHxcEU5a3uketJsbHuWE22JW3vPVfbnd2EMi30gRNpZIBl66wOVNmbTNmIXlF
 vYtsCh1CReQMOIJhB+NVHog9mucbVDvMFC7miUn6uvsXlj6oh8GRgnT8uZXnl0Pcy2B4m6274
 n0aBsOHBpq6qSOq0RG6CdVzPgirFJwhGY9ELCgQP6IrhDsDFNvVS/biplqjPX6d/1SrFkpLAy
 nAaVbI0eG0P1o1xUmKpCA1ys6zxLBHRwp4JKs8GT/zouxcsGmNpSvb9kGYT4G1WJ5E9RmA35c
 P+wj7nuTVdqixrqCqjd4VE4z2C4BLpNw30pGd+ehBO0gxSkJXjz3ot2y+TiAfrUu+qQputvRW
 8/p7CyYZUO3RDY5sVwHc4Mi950xr0A91QxuiEpzRDHDxKVRH4zmxQcPW+QnyfLAbqeTWURAWx
 8xEEsVsYXKHtbTvQ78KflCPLh9d0zKjjMtAcvDlBcD1yskBe7GXNo7WYvw5fFbEYUskNglyYZ
 fy3E4aAIfD9GU8RPfjUiThYcHMPKexfhc1sdnJ39sleQivwzCrxuVBEfHnGH1ZxYHIOKo+FE8
 YTu6eKWa7DbfWQjQajtqS3J+btGW1lg5+u6hfnyJ3cf96HxOpmcD8PHpDvFG4aMxhRc5d4oR0
 mGlQBq9sikMDVTVaMYY3ErSaELLMh/L48WER2wlX/3o+l1Ek2ajztvBWmxCttBE8iIyZlq3FN
 r8uj6u2QeMflvjwrzNdyL01+v35N3q5VYezu6Wm5gWBsiDFsmFXKpDXOhiYJ3V4qd5sp+esEk
 Lhe7qU+eMkONyygB0SnaG2MvHPqmWvkTUyEm9+LlDSo3PS+TsgCF2WXfjorHQrvc2OWlXQ9Hc
 yDFOguYkGwQHpvMlr7+JGUX9ye9ExFbTrjCuOu93h/nOADNvNm1bzL+vv2SGUT3BDWTI31ufZ
 nxv7vfo8tIWlm8sTXPpaZLOjVMVgmPwXmsqajIYXQYhtUNA9fq4QJf04QNjPdCxfknNebmQgw
 TZ4KMycXh3kHacdVOPK3VrdnjTdBVEp6di/Bjho2P0FyZNkcIbrgqz1x5EL+oriV4ndfonbKe
 XvXyjFa25cRf0OkVfFL74SIzHrXf4aqlRjc3PYIYEjX4M40f4GN+iV/bXlLdIwnGQ3+3lO7gX
 xON+2e3EwRFUizkdWmi+Yq0X0dJ6YFv/OLmXLiqyzZ8fEz6mwSPSb5gBQwkbk1sGvt22HICvm
 CEEJyQkegxMfFX/kWy+Mh8cZ1Yxa4P5i7KU2YzXkrLKcBIZvHU85ZzOLBp/25iaWkZfQUJzWr
 sPcbNNkCQ/d6TjL2lTNMShL0o0uk0GatWhZlD2iGPWvqqOwjHX0KmQyZVVmy1ehDl39itzAkA
 a1ATAz88CQsQeKHbCDxvcoj/wDaatvvRFDeIklnJg3AO7v6eXLLm+kk4wGuj/g==
Received-SPF: pass client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Le 16/07/2025 à 21:24, ~wojtekka a écrit :
> From: Wojtek Kaniewski <wojtekka@toxygen.net>
> 
> bFLT format is big-endian. get_user_ual() returns host value so for
> little-endian target and little-endian host it's necessary to reverse
> words using ntohl(). For big-endian targets we end up with incorrect
> endianess:
> 
>      $ qemu-m68k-static ./test
>      BINFMT_FLAT: reloc outside program 0x801f0000 (0 - 0x41f0/0x1e40)
>      Aborted (core dumped)
> 
> For comparison the output of `flthdr` follows:
> 
>      $ m68k-elf-flthdr -P ./test
>      ./test
>          Magic:        bFLT
>          Rev:          4
>          Build Date:   Tue Jul 15 23:02:00 2025
>          Entry:        0x44
>          Data Start:   0x1e80
>          Data End:     0x205c
>          BSS End:      0x40a0
>          Stack Size:   0x1000
>          Reloc Start:  0x205c
>          Reloc Count:  0x17
>          Flags:        0x2 ( Has-PIC-GOT )
>          Relocs:
>          #	reloc      (  address )	data
>          0	0x00001f80 (0x00001f80)	3c200000
>                    ^^^^^^^^
>          1	0x00001f84 (0x00001f84)	3c300000
>          2	0x00001f88 (0x00001f88)	3c200000
>          ...
> 
> Signed-off-by: Wojtek Kaniewski <wojtekka@toxygen.net>
> ---
>   linux-user/flatload.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/flatload.c b/linux-user/flatload.c
> index 4beb3ed1b9..afaff4ac44 100644
> --- a/linux-user/flatload.c
> +++ b/linux-user/flatload.c
> @@ -413,7 +413,9 @@ static int load_flat_file(struct linux_binprm * bprm,
>                  relocated first).  */
>               if (get_user_ual(relval, reloc + i * sizeof(abi_ulong)))
>                   return -EFAULT;
> +#if !TARGET_BIG_ENDIAN
>               relval = ntohl(relval);
> +#endif
>               if (flat_set_persistent(relval, &persistent))
>                   continue;
>               addr = flat_get_relocate_addr(relval);

I think the ntohl() should be removed totally and flat_set_persistent() 
should use put_user_ual().

Could you test this?

Thanks,
Laurent


