Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC951C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIx9-0004jO-KE; Wed, 26 Aug 2026 15:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzIx6-0004hw-Kg
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:06:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzIx4-0007s2-QR
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:06:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGugiW1408689
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 19:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rYC8rWwb2CJyBe36pC2ps6aD4zJ9K5r9WG37Oz3/QqM=; b=GsKqzTFy/xc7tA60
 rff8ZSei/77hxQtWZjUvmh7QBlEBRF3xv52NTCdljENJxpyy2mfYGKX3gFtwaM1O
 A3UqqnUxaOGC+sPG+xpp2TsD3zfA/saEcXrOV/QVMRkZjlVhxf4tuvoKXwLsmYSt
 2mwnCo8n9nw16wvgkAAUQaFAb5PhCJHSHAT6LGGQ6iorf1eY45MfdhRyGWjAIJfg
 q8+kKdBb4kR006i51KpdhVxQnArGm0c49SmhY/cL6bZH951/tjDZ2pzLOK1hJ1k5
 2aZdoI0VOo84bDYqv6gayHt8D7AU4XSghSt5ZgQNMrpvzBONz8E+kvu0x0fQdkXz
 KjKPKg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9x2n23py-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 19:06:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5283df62d68so16751401cf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787771181; x=1788375981; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rYC8rWwb2CJyBe36pC2ps6aD4zJ9K5r9WG37Oz3/QqM=;
 b=YEqOnhqtU8Tk+eDYDZD/EhcJ7LOO6qq+3dwsxuLY9VybS2iNloRNZgSj3HeGTKauhl
 FOw8Q1SJzo54nr9u0D5CGOY6BSW2kyFcZAfxUo3qXpn3hOaPU0JAQaX+Lv9YNKD5Ut1a
 cfbskfD79zWhnxp4T5EZiKuFb6lT013wQP2STSZ2AD4BG0l9j8FjgE0rpZwp2HciOgYw
 AZ02eQhOb+oE+hWBvgzhWcmNevJCBJrbebVtBEpBsdFCuiAizrB9tAKTyNW2kspj1YlT
 OPD5z1LZdRu6GsVZyHoMjOs1rvKmad2QA5DjSev7EIgQvukaOrEboyJEfUqv6tgpgWuG
 PJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787771181; x=1788375981;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rYC8rWwb2CJyBe36pC2ps6aD4zJ9K5r9WG37Oz3/QqM=;
 b=UFm9FXschEEuGJFx9fkQMDIZXZKSSBa2TlzeW7uLglzF3K3KgyONnROQC5Y5JVk7e5
 eT/50UpP6BsGW7YiEmi1vl9rmZqQQWDNf+R++nPHPGfDp9J/75tWvojAWMheNvsWyXjr
 vEiJbm3bj2l63goMjw5jZMc5ifKUiO9idicQ27lKutyxZULepW1aWwFN2SOYGH9eNUFj
 SJq7pMvvLJ++z/hzQ6vZTu7KHhOOAc9Bhm08+CoPWadxavxuFJutrnLv+2Yew5oofKL2
 /ffXsp7iFqc0i+YGd/G67A7jBRNyuatM2XbOvWL3oLozvtmMeeyR6aA9MC+6KzYHF12k
 FNnw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqsh3TdfCH/Ve/Hl2xUw5PfOc0r07xS+VSQziYNaPYODTUs3+vRmy9iiod5En/6RE8JtK8/3bubhTkq@nongnu.org
X-Gm-Message-State: AFuF++n5QjGqi+poc/QrVTBLS5XbYWW5ucvGs+pVyxCVp/mXFFsriVOD
 mDnwjLW9UZetoGOzBcJ8EwwafDx/hL0YewSul1A726nuCcjNhyC2JRWYWhJrx0ps1ttGtGCK1dl
 24A4VlVMZ0H7D0JwNliiIIc93l1r7U6eXElzzJFFUniaURNSEbaxPZBCe/Q==
X-Gm-Gg: AR+sD10mlCy1sqcEWbI8m3AQ5K5i2GfCQc5JcQioDDRmbYzpoVYmu3AzH9Q+hIAsxFt
 1yfvQOTZ/rzZFfiphfA2k3ilPJBliMK2WDQyfRblCzq0X5bTXCNi49Qh3B9nZeZCpYM8T0d8Rc/
 TPWMNlKxbpmInB2KuZQXmCqoBv3V9We4pVoz4fDWFeGsJ/gmNIWT5sbhlwuIXI+hrSlvfp2CNZ2
 5qUP5UfGOm7ZtmRRzn1I3ghqYXgbfa5GwWNMUK9j3wXSprkx8y+VfrR+GY2p5UymIB4kU3rs76y
 vOjupTQc7iD5k7RJ3sB3khbWALArTLqhAxqzd4vOzPeNz6rEqUwoXjcF0swtlLvng5j2gb7vM2w
 qg9SuEVw2F74c3mVlABJpuYOi96BWxpnL5qhGCWQdS7M=
X-Received: by 2002:a05:622a:5c07:b0:51c:f3:34df with SMTP id
 d75a77b69052e-52e42377f32mr103323691cf.30.1787771180108; 
 Wed, 26 Aug 2026 12:06:20 -0700 (PDT)
X-Received: by 2002:a05:622a:5c07:b0:51c:f3:34df with SMTP id
 d75a77b69052e-52e42377f32mr103322361cf.30.1787771179413; 
 Wed, 26 Aug 2026 12:06:19 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8b641fsm5762088a12.3.2026.08.26.12.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 12:06:18 -0700 (PDT)
Message-ID: <845658f0-5d70-46b5-8c3f-a018f18f1b17@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 21:06:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] single-binary: link ARM and RISC-V into
 qemu-system
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Bibo Mao <maobibo@loongson.cn>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alexander Bulekov <alxndr@bu.edu>, Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-arm@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Darren Kenny
 <darren.kenny@oracle.com>, Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20260826184229.1145-1-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826184229.1145-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GAdM3AtWZk_aGO6UxVEmR28NFzMceTP8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1OSBTYWx0ZWRfX/faSAjgWPTbb
 DxpzrXEwLuPbZj9f6N/hd4VhDxB21vl4Oj6RSsoz1qZb5LZqhX+1MnSWI12ZDTlg4sOjnstDfT7
 ITElgrDoXV9QibB/lHIqb/rI58XZO1Y=
X-Proofpoint-GUID: GAdM3AtWZk_aGO6UxVEmR28NFzMceTP8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1OSBTYWx0ZWRfX9PYp+BkJp5XW
 ZYqljEBXQzB91MMWw8x8hBKULl3VELEHu+zNzkr2HTNV83QvKWuoSSUqEc8EpLER+BpSbre37Rk
 waMWwjVyBcBzbIOaOE5cfFooqxOGe6NHEFukBkIV6RrKqaMtSyEtMS5/U3DOXCQbOib86p71WEI
 ns/4x7UWacywcxri+8ApU/I6ok86KXTtq8ZsHTNR0BSh0AgUo5oHF1i9+03znY8OP/wcYf28CMK
 u8dkvEIjGjpYE3vmRHRhZg9MUeqge/ySTWiKgPMvDv9tmtsDlrBZNdtksrJnSMUjZK0e+GEC5eo
 /vW7aPttRjfoalhbUV3WEPqfKVkKHBOMv8Bpk/r3S1x0dHEeiKZoDYQdC9SJmUKGSPnv73YkMZi
 RtHzsrqJbXeNQvsew4GoQ+POc4JDL+uuLD66gG4psy6hPxjle+stBn36lEEs049iCRFzt21Zdg5
 D6A+lpu+curIZhmRHVQ==
X-Authority-Analysis: v=2.4 cv=PPQ/P/qC c=1 sm=1 tr=0 ts=6a8f392d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=q2Dha5Rnfv4IMWUVstwA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260159
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/8/26 20:42, Yonggang Luo wrote:

> Changes v1 -> v2:
> - Drop little- and big-endian TargetInfo variants from this series.
>    v1 registered target-info-<name>-le and -be, selected is_default from
>    TARGET_BIG_ENDIAN, and accepted -target tokens such as aarch64-le.
>    v2 keeps one TargetInfo per target_name. Endian variants are later
>    work, not required to link ARM and RISC-V into qemu-system.
> - -target help/? lists target_name only. Unknown names point at
>    -target ? rather than printing the list and exit(1).
> - qemu-system with no arch suffix always requires -target. v1 could
>    still pick a unique TargetInfo when only one was registered.
> - Keep qemu-system-$TARGET; qemu-system is an extra binary. v1
>    described installing per-arch names as symlinks to qemu-system.
> - Do not build qemu-systemw for the combined binary. A Windows GUI
>    twin would keep using exe symbols from DLLs, and data exports
>    cannot be delay-loaded (qdev_prop_array / qdev_prop_*), which
>    would block enabling modules globally on Windows.

FTR I'll wait we finish discussing on your v1 before having a look
at this v2.

