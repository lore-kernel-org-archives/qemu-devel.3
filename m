Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6441CA600E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 20:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEuzj-0006CJ-12; Thu, 08 Oct 2026 16:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEuzg-0006C1-Ue
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 16:45:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEuze-00080n-U5
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 16:45:36 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HVXal4038880
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 20:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n7jzz2QvKb3fecUVZzAYJFQJe0PcXJfCrGo5UuuR6Nw=; b=f1F/Y26xQLnK3bX/
 YXAlItw/VCUP72Trqby9Vx/TFKdiLUeSbX1jNji9q85+IKsvY9ru4JHRzgP7HUpC
 xPvHkl7SY7lBclpcVmrPspyuSA2FZ4XeKl83zSqflZLNRTytMAijzRtwDsx/yBDq
 UlFw7FRl9R4rEfT2yFv/bNLJ8jvfVC0220H75HXiuTR0nPfKc0UFCLH3aNhYI2Lu
 TFd5WjDN6T8KyJyODlzBcaPNl4LtbBy3Jt3jW+dzaoGDhihGu2HLqQ6gVPIVaCN9
 J2CfNlkYkIloqMCfR/omQBFnj3glOoDvbrJItJtmCm20s9uMN4x4Cz/9Zn2m1G56
 LvjGYw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekv8x32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 20:45:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c5ab5c136so960496685a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791492332; x=1792097132; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n7jzz2QvKb3fecUVZzAYJFQJe0PcXJfCrGo5UuuR6Nw=;
 b=egF4GlG9FPhbOQmq+4BSDKwxRbvbFgKUraY7ajOndffePL1JanUxHBBMqDlncz4pPH
 41389gQpiLRgF3TB4sv1DfY8TzOgSHbFCs/zQclGXRxxszBLuPEU18ypOBmdMm/lge97
 /VHJvmDW2SlJiNslc6RUZQVZMoQ1yzDEl7vzXOAkBrpwYguZv/4OIBw0sUP10OawuRpe
 8zW1/W7WCJjaJ9UWzckrnu3X7yBzuAM/zCPJNGs7dce2rzVXt68ngGb+ghxarFT9w+bK
 7n6m5KuKQZfEqFwMkHQs326yVZa5eT7ZkAUEULaof6SAUjBuQUWL+W3tT8RJQ0xlPQYc
 LxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791492332; x=1792097132;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n7jzz2QvKb3fecUVZzAYJFQJe0PcXJfCrGo5UuuR6Nw=;
 b=fa00VtlEbjmEGM0lhtwAh9gh5Z97yNP7mQm1EE6vpDBihZQg8m6XiEjIroDuRkmPZp
 tFF5RfuhD2gBH3vrlQKsOCqAkedw1EfrnyJlLbBnPsjP1FeV+F/or0neytSoEyQNTVPC
 wgVNXRdCBCEYpYKy50ZIKKEthzBpGpVCc9omNzexFy6upe6CxR1xCYrc8zPx/74vqZ9p
 Zo1iH1FGUKL+6fbn3FNOkffQ5H6x3W8LsTyxswnMvTzBGidWsizmO5FjGaqvmV7GRgnZ
 nXHmgCd5S0RG6YQPJLPsJDESFR/eMLioX+z3nbTurRWTHlE4GA71BOdyLRQvGgNrRabZ
 ZgXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBze/U8EtOzw5Sz5Vm4jfM3TWYyKuJ16s2m8b4SCo9CkvRHSTYDJly/JdNfDnS8zr/B7ai9ITmmmLV5W@nongnu.org
X-Gm-Message-State: AFuF++kCmLStTwEQTZlY9IYevitOpNPJMG/PR3Dn9k3ZlTurXILnmwOd
 CUMFHP0HP1R7F/mIecVIt8RVb0WpO3tq4uOMmNVXanc+vbU1CnzFoy9/tL0i18P/RSWT22Nq7qg
 H+nMn8kCPOSRrThRu3S7cU8rjy1DSz0igT9RqNAiEksikr0a2MEcakilIrA==
X-Gm-Gg: AYBFou2cdTjYAG3PuC6ZqBKNLfd+xqicOdQv/LJNys27185SgunT0oxeUK0+uYkU3JK
 eb16/wv4AHZFSONydjSyeZUfLgFeMqtsQZyf6T6kBJ/vWzI3mhjmlJ5JeIO3IOOPDNs2amtgl+2
 0MnNU+X3I7K/SW2pqp9jROMy595KD8A89TlSrHJ8UFIVtY/INniKBSyodCw7JfXXOZMPfdK4QQt
 qWHvRYYHeCg46gUkWF5wJoJ6J/iWreYBSXDwQqda00AgZFlRCjukJvJnNFzMj99XS8W4ZPL+OOL
 TDXtAlSa5viFIOlpAum0mc87CTXWnbt5O51UD58BvmtnRuFQRpFXqexnRdeUT5tdjE3L0gH5H9n
 3+zWn1gj5BJXK/yD6Moh569yD4O4eSqh+xw==
X-Received: by 2002:a05:620a:400b:b0:93e:7898:4d73 with SMTP id
 af79cd13be357-93e9b7b1761mr1066093785a.45.1791492332051; 
 Thu, 08 Oct 2026 13:45:32 -0700 (PDT)
X-Received: by 2002:a05:620a:400b:b0:93e:7898:4d73 with SMTP id
 af79cd13be357-93e9b7b1761mr1066089485a.45.1791492331557; 
 Thu, 08 Oct 2026 13:45:31 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9acc936sm142101f8f.44.2026.10.08.13.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 13:45:30 -0700 (PDT)
Message-ID: <5eea35b9-6a38-4999-97a8-15b4f7d8fa57@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 22:45:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/usb/dev-mtp: Fix assert crash on short
 CMD_SEND_OBJECT
Content-Language: en-US
To: Tommaso Califano <tcalifano@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
References: <20261008122936.45081-1-tcalifano@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261008122936.45081-1-tcalifano@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PvWAjqSG97IKAsKzF8kXvRy9jxtu_jqO
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac800ec cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=6Pj_epo_ldZrC0W2bZYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4MiBTYWx0ZWRfXxabky/hs+OFy
 NyNcrs1eeFN3r9PgihKYaQ6AdiP+pXRVn7IyvoGaesdg44L6JF3pfIRPcr3PKV4gyDoVcY6WESx
 6jYthz6sWRPG6JeNx15l2MHJLNBBVRsIUzV1+WAnox3feBuNtw2cqiim6BCuDQBzGpR3fSQCYvJ
 eJRGlAeC2MVPBnSMH7hPZXQLVbTMYj3NsjEIM9gG4fUOiV7Xx7kB03XT8W69XFMVatXU87jP0YB
 3sIzNEkJlkgveGoX6Ylm0tElV5fwRzbwnXH37DQlAgxc7rRbF+tvaZZEv6tVAEu9aTb0At8f+Hc
 5BIBuTyxf5+BWkCGmnkAZVUD/pzBA6ETe+Kre/KbJRvmg/nt1yDayYUcsfNoouEX+sHp7a3wH61
 rg1ItdZNW4QYXAXo3Vyvy4SCyH4iZDyLyN5K+KfRSYRxdVgihqbxuoJqWmszCxrF6UIk+pgLWHJ
 N/hcIxxMxxiZx5T8UQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4MiBTYWx0ZWRfX3ePECl05T0ty
 IEX+h6HkGN3U+2laYuQBkaDvmVUnccWiHKUBg4gY5RpFOLoJ03JuQ++fAhUf7Hb02Kn00KZ1ndX
 pSc1KsWYvpZDLjsdL+gissPicAgyFYo=
X-Proofpoint-GUID: PvWAjqSG97IKAsKzF8kXvRy9jxtu_jqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080082
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

On 8/10/26 14:29, Tommaso Califano wrote:
> In usb_mtp_get_data() there is a guest-triggerable assertion that fires
> when a guest declares a large object size in CMD_SEND_OBJECT_INFO but
> sends fewer bytes in the subsequent CMD_SEND_OBJECT. The assertion
> compares the declared size against the actual bytes received.
> 
> If the guest sends CMD_SEND_OBJECT_INFO with size=1000 and then
> CMD_SEND_OBJECT with only 50 bytes (short, non-64-byte-aligned
> final USB packet) the assertion fires, killing QEMU.
> 
> To prevent that is sufficient to remove the assertion, because the case
> is handled by usb_mtp_write_data() which returns RES_INCOMPLETE_TRANSFER.
> 
> Fixes: 3e096650a64d ("dev-mtp: Add support for > 4GB file transfers")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3993
> Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
> ---
> V2:
>   - Add Fixes tag.
>   - Correct and improve commit message readability.
> 
> hw/usb/dev-mtp.c | 3 ---
>   1 file changed, 3 deletions(-)

Queued via hw-misc, thanks!

