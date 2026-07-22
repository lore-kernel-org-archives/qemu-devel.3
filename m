Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CDAC4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmZYO-0005Kv-9e; Wed, 22 Jul 2026 12:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmZYM-0005KX-6u
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:12:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmZYK-0002O0-Ov
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:12:13 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MFYMFE1052568
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v7XiaqPgQV6FqC76nktEIAt5FlAlAQAnuJ0sDv4tbV4=; b=mg24E2OoeJH5w1it
 RGCW96Cknqfd0Ywiswphi7iIGbwO+OQdMtoG4bpE3CutVx388HoX6KV7y8EeIDiR
 kc5If/iM2j7UKGbDI1NvHfAHnPttIm1YBSHCr9UANDoTiObRLdAdUsokFtuCgURI
 hBA/BbWqO9EtreV/zAXKo2sY+YH/9j6LRiyxt0ptT8x22KjtShg9UbT5GGT49L4D
 20KZ2rZ87zv59x6Uf81bL7Q1L0jfU4BnX/dh0jR6KR9PituIKrT0NSrFpW8JLkXV
 uTFT7l+sSoSd8XGnMOM4ZqDp8LN8h1HlqACy8P90ky0bVsDyV7QJXQWQWkbXAlaX
 r+2fHA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjtn2sx0g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:12:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so19526047a12.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784736730; x=1785341530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v7XiaqPgQV6FqC76nktEIAt5FlAlAQAnuJ0sDv4tbV4=;
 b=io7hJzY8QBN8uwv9xhfGVJ09S57nZlw0NCVVjjTA6RKnTKesN9UivPIUb8fQ3o+MpA
 V0j4lUcgMLEbutIpnGBidV/VCinjBezFpDqevcrM2v4U/GNfX2MQ4GdA+f9IrT2DV3Qy
 7dwJ1LlAivolZUcaj17chkA4avdEFmqW1hIRiC+55iKc86/RNrWHeN/k68J4SGQ2HAYB
 t4LRjssLLb4NGMd0kUBFbsET6qgkkSvlsw1slS+cfZ+nY9PkKnocMuEGf9hvQVzGb/hO
 jFTfk5hZoJxyOGGBZNoXrcU65ektcNpBUefpl6JlUeknFWM3a6iGdzJciGieXbtHn7Sg
 P1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784736730; x=1785341530;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v7XiaqPgQV6FqC76nktEIAt5FlAlAQAnuJ0sDv4tbV4=;
 b=bxfzNygYD6HobJN0D7R2/HZFqE1rJxU83CvVO8ksptKv2phPh00duwj0HR14HQ0KEP
 4Gb0Ta2U6GNrsB2OVgJz7Jbqj0/tbENLBRUNC/k5hH4hykzEsE5ewyo/tqfm2gIFKlnQ
 WCQkiyp8wSnCQQyG/ioylBHp9+VG3YZ651kJnDSAyiLTMnISCzY2uG2bp5VTBAhmCpfA
 Lkuf9DRG/b7DuIgqidC8xa5geTAzA0B9LJQElp85XJTzgtUU+F52Dog7h3OmDgArlz61
 pyv9N4PqrF6X4F0kVAyVsIP6JhZrJu9yjrCcvf8NJs3FGA22BkaHB4q7hGIZJ2Gve49O
 L/VQ==
X-Gm-Message-State: AOJu0Yzp2m/RZ/U4hITNzxvQQkiIcZX7wm+f/qDKWjEzUlO4EybgcTfk
 5+F1R/3+U2yu2VDS5tu0tdCTwQ9B3V/BEvtnwUM9+48DalTEYqlnY5PF4iYvLMR5qTemcTnT8DU
 6i6Tzn5PK2mIrG9whwb3eiE5Q9zD/EWM5pVz2qHf+HDcfkUj2qnmnPfujBXnSFusYrQ==
X-Gm-Gg: AR+sD12Jol2lAyIeSzXJl21O0OmNx0NDJJUQ7rsOXywAFTgaRxKlBi8Ox8ww0Kxj7EK
 X48QLNfuLXw4Cs6tVWggl6lWKEIMHlZC8WuyQaURMUsSDenXN43FWuo7OtOJP7i9CTAtoq91BbK
 U+4a8nCIsI0einMMdihCuwnNGeBd33oJs37lhe2jryzqIZxLqXiCLLLVsrhVJx7Li5WMA1VAacq
 SkgLOgeEJsv1Myh77vIl3D1cR66b0xK44d9JiOQrzaGXpjNOZftoujX6quZsG3VYBgLwxdL2bRx
 NMGeysa2Dft0v4nawlmXPznc/EKblaKIK8eYZRupWOHD1CewzV/+jH0/ET4VJoDwYrP7eBmzl8B
 YzkPOxAeBgMZa84TquWnG1Bg8ff8hKR2/tNgeDF/drT9uJGdhmfvxxatD2VJRSRNDr2j0
X-Received: by 2002:a05:6a21:7111:b0:3c3:7cfe:b32a with SMTP id
 adf61e73a8af0-3c3ad7a4367mr25808906637.27.1784736730376; 
 Wed, 22 Jul 2026 09:12:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:7111:b0:3c3:7cfe:b32a with SMTP id
 adf61e73a8af0-3c3ad7a4367mr25808866637.27.1784736729926; 
 Wed, 22 Jul 2026 09:12:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d1302659fsm8104919c88.8.2026.07.22.09.12.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 09:12:09 -0700 (PDT)
Message-ID: <a9766fa1-7c20-44a2-b12a-9d3455cb9198@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:12:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc/cpu_init: make cpu listing determnistic
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260720192403.66694-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260720192403.66694-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX5cjfGLsgGC+B
 plLDByEWw9Y7NlPCATLDeGimKCSVqsdmAZr0KnQYEC7O67p1CqgNoHZOLnUyTDnu2OVAkxbHs00
 vDbGrNn7gAXETCPXI1WW1Q0iqoU61vdjlB2qHI+eqLzgbDh5Sr2qLzj/JmIGlUTui3PEEPuS+wH
 dDzfAQVAN89N5JixKPe5o+IPzDr2yqu6znO2oKa45ASHGpo2dYN0CipHr9WXedFka3UnGpbUpT3
 Lb63IckkWU1207wgXkvJy0Qtu6ZJLd+BMZwn3CkWmGhqFZslerDb8+S9S2tPBqd/GJp8gsy34IU
 ZXu439AoUKO2iUyieuFd75T5DioVexl8pITNFmbUaTUg7/NrXEvX2Q1XHaZw4i0yqFkIRYDZGg3
 fe6L+VSFbKMFHYBZlp7HmQH2850GBOkEUdN7PF8YImmxucgNNfh0fGR9oZ/IhAUpnCjwHKV3pO4
 3OVlOTP3tzktqn9SbjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX+R3/NyHCee+a
 Yzy81pP6+FRodWeADPCfM5Ltt/myJ6dyLjw6j9uKP6RodmhjnWzG//qCbqMtWvTS//LqA2WTU6a
 EtMWM+SA+wYwkQEuZPLn7Hx2AAyxg1w=
X-Proofpoint-GUID: 5wl3WynOl9X_RLf2dlsE3s5Vfplu0WHi
X-Proofpoint-ORIG-GUID: 5wl3WynOl9X_RLf2dlsE3s5Vfplu0WHi
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a60ebdb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Z-4x5wT5InqdIIAgZasA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220159
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

On 7/20/2026 12:24 PM, Pierrick Bouvier wrote:
> The existing compare function only make sure that we list cpus with PVR
> order. However, we never compare cpu names.
> As a result, while cpus are grouped per PVR, the order within a group is
> non deterministic. Depending on QOM type initialization order, we get
> different results for -cpu help.
> 
> For instance, previous output could be:
> Available CPUs:
>   755_v1.0         PVR 00083100
>   745_v1.0         PVR 00083100
>   755_v1.1         PVR 00083101
>   745_v1.1         PVR 00083101
> 
> While a sorted output should be:
> Available CPUs:
>   745_v1.0         PVR 00083100
>   755_v1.0         PVR 00083100
>   745_v1.1         PVR 00083101
>   755_v1.1         PVR 00083101
> 
> Fix it by comparing cpu names to have a stable result.
> This allows us to record and compare various command line results across
> versions to make sure we didn't break anything while working on
> single-binary.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  target/ppc/cpu_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index f404c7e549d..3443dbeeb01 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7130,7 +7130,7 @@ static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
>          } else if (pcc_a->pvr > pcc_b->pvr) {
>              return 1;
>          } else {
> -            return 0;
> +            return strcmp(name_a, name_b);
>          }
>      }
>  }

Any chance one of ppc maintainer could send this for the upcoming release?
This would help us to compare command lines across QEMU versions to make
sure there is no regression.

Regards,
Pierrick

