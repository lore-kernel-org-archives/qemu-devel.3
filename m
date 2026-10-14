Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D125CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5bF-0001Bm-Lz; Wed, 14 Oct 2026 16:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5b7-00016m-Pd
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:29:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5b4-0005vb-Ng
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:29:12 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EFMihV1682652
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uPdt1urhW52u/UotlFuka+0DwPFxn8Wxeo6/WGaABFU=; b=lvxPkKLnzcWt17cE
 izlpFr/2kxTf5A9yW/YyZenXsAU335Ijzgmgzbh9wLEO/eKCEhma/SJ4FS1LW3Kp
 pWK2vKh/uZ4KFy+K98U9nV9+B3kol3P4JrS/FMg/9nqLb1Jh+zx5hEUsfuAjOChN
 4ue7FYO4VcGp6aHu6otnciOGdSasD7I4fljaer3lzDQKiMGXYJ3nXfPoVoJafJkq
 KB//8IEjc+LdzzrbIj3S+Tus+ZFMf/gwV1P2a+XTmtSgLOrcaOPbaPYIti+KIg1d
 +/l21Cjv/1m6lXOMkTrJtX+bfcSbrcOiDkQ7xBHcOKxLywVLQGL+X8T83vzvOSpt
 JzCOxA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb0155e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:29:09 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3510d0baf63so4341113eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792009749; x=1792614549; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uPdt1urhW52u/UotlFuka+0DwPFxn8Wxeo6/WGaABFU=;
 b=cOyjcBYd10aJ0HiGbIQV5g3A0ZljK2apGzsGEYEwP3/URhdpcB8PugvxWS0gA+lbuR
 rcQIgGRMmQaw+wQlNXlATjWEC1/vbNaDEEMsmIskOONbKAHaVU2PzwQS/gqs3IuVVEli
 1U2PaFeKp6CRW/O+8Ar9+67lvCShkyQo1jHu4zs3KgWEEjr+iaulL6g5OWqNVVYiYbut
 Qs5rpvSzvhwDCnD5QEHNwHzap6bCWskuGgv8PDNuWlp30GL9O43kyJIJxooJrOrRmTRS
 neYKUBT1vAwCwi4c7cnNVfpZj20uPArQuYS7pTiRND4XHISDns9y8eAR0KMuhnTb55ru
 FNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792009749; x=1792614549;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uPdt1urhW52u/UotlFuka+0DwPFxn8Wxeo6/WGaABFU=;
 b=pxc7R+bz/zuXod0Rfs+RBWut7VLW79F7LxBSxQqFttama3nqzBdNzyZLDCNo/aLSf5
 nc/8pLRCHXf6OQB1v7kQYh91b9wcVwkRbbTyYyKfrKaRRJNFAUzwiNleV2h+h/qOVsUG
 KFcAgDqOZzKkBx5lzEQ1ev/nnC++moGdF/xFuKHfkfVJPCAqp/hlOx22SaPYvcOUUupB
 BFSIczJPoPbBjUxmEynhdH6ETbZCCT3077HiUEjxL0ERKo62IHrDVd3+mcN9xRlS7ZR4
 5myJ65JhZfUcWjxorZMBB4vwokrp1THkq1m4YXufFgXY7bzvoNiR5vp6QhjG5c7kLWVy
 ijGA==
X-Forwarded-Encrypted: i=1;
 AKwUvByrMy1rChrDKtHxLHe3I/PT1ae9Kh8EE8vlF0TobckBYg+e0DyO2YpyaikgY3jSPjiW2vaAb24Oh7Wr@nongnu.org
X-Gm-Message-State: AFq9FYIHVE1mnzDOswEEVgoKdzoc8UpT0IAzsmjMKKk1W5ZD1e1T9nzf
 wl6z6MswXqk54UcOkPF4GDmseKthD5F5i7dkH3Ro55zvU3S1MfZNszWSsI7TLAc0bQLolASCYfz
 D/0dvdXY5TQ3vBEkn/IH3aQGt1pMiPJ2AVsy+7iJW/FBwktyi2kkimo2t9w==
X-Gm-Gg: AYBFou1DyXtrLt3k/xCsV564YD9socJ12QST8xLzJCvWO2VYZrevBgCRJTkLN8I1+r/
 QMay/K4eHLZJu9xe2s+12xdbRtqYfppRrREWQY6z/dIEo3xGTz0I0Lw0EiwaJ8ceO20YTHpiJ01
 n+FCoAUbxczq7W7iakzGB1fyDj0O8EBtn7po1MaXHIJ/JLDidhxMPxcqYyKbqqFi8kJ4Axwt8At
 VCTMGaiE+W3++cj5m8Xnu8swqYJD9td+dhU52jNRcylohKWZSMKeM8laA9/o44ioPDe86nb1qjA
 8g6VAcvpAH5pKhhQdgz63z9Uut9ga9imxbhuLUrX9YJnWpGj6RJZ5YNnzcNR8L26dIeYSA48F0U
 f61Ngccev9V1quYPaWt7MJIx8v8oOtEain4SAHDjrKR4ucR3zkLIzMzl8J7kU8A42FR4UTA==
X-Received: by 2002:a05:7300:8a1d:b0:351:35b3:c5b6 with SMTP id
 5a478bee46e88-3537e0fbed7mr26154942eec.27.1792009748547; 
 Wed, 14 Oct 2026 13:29:08 -0700 (PDT)
X-Received: by 2002:a05:7300:8a1d:b0:351:35b3:c5b6 with SMTP id
 5a478bee46e88-3537e0fbed7mr26154903eec.27.1792009747974; 
 Wed, 14 Oct 2026 13:29:07 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb6a279sm54541388eec.30.2026.10.14.13.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:29:07 -0700 (PDT)
Message-ID: <59c44246-7f58-4b57-89d8-496769a35782@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:29:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] linux-user/hexagon: report ISA HWCAP through v85
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014195223.3233623-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6acfe615 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KJLzXn_fNX4Yjg5shmgA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfXznJs6FHl3xBo
 SDfFqqO288ph3/DBeJxo3fpj5fSbeTNTqWeh5a/OFMYRbr7kKaKqV7OhTMaRI07xEVzjZzQa5aw
 DUN0Id4krzsCO4v2uOtjqlUSmM7Ab6k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX4RPvONqLJ4Fm
 dCzhckqAVp21pUPAZQzBbUdmtZQsrl+nSP9yTJyFWMFHE7cWDUTUBCHd+hHqx6SeTb7iyu/k3Am
 Yy1ISuQSgO1VGYVe1aEf+MPzgWGM3yuHt0ubt9mKgQjAsWD/7T6u1rfh3bI+dJwCoa2/iM0ub90
 P/7llE+nM9nH0BUHa8BUMTltVtN8Q75KHW79xLpZIJsGV3f4Us2LcMOrk/da9KfEGV/Cprg6Ff1
 c/Qc7ZULtoO+GVpmSn+5zTLeAoqBdAoFDD9+dIvst3y11IYmi1xpDX00ofyivB3TG3WKhJfe0ca
 Ir3vAZW2ojdxBNk9F3mXf5/Cn9EAK7kZ8jXDbWbnWvURdydlTqWoXZOvvHQCdgHyd2K7L7mRflx
 9FzUAA77uYYN1DfxvfLmqiXdSrD0MnFQ8EbZXzq/VUfyuubD7Aofpla9zgYx1oVDlDDXXW+hoGs
 xYosG4xaFRu/9WMT3iw==
X-Proofpoint-ORIG-GUID: GSNlUEc8q5L5nFIjsep9jBi84_Wz2_Gp
X-Proofpoint-GUID: GSNlUEc8q5L5nFIjsep9jBi84_Wz2_Gp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140081
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

On 10/14/2026 12:52 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  linux-user/hexagon/target_elf.h | 2 ++
>  linux-user/hexagon/elfload.c    | 6 ++++++
>  2 files changed, 8 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

