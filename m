Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B04AC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5cR-0001rK-Rj; Wed, 14 Oct 2026 16:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5cH-0001qo-2p
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:30:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5cF-0006AV-Fm
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:30:24 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJlw3642822
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cHaSXuBw53oB/JpIaeNjkMnzhzxN11tSl3sVfsC9c7s=; b=PlMuS88S0MgmAD0o
 TQDTWo3NfB62LkiB4DuoyPzvLLyjBxDHbckkGEY85YLN2M+LgLz6qIfxscJf5LCB
 WLd4vRktUxM+SPfg36IKobjrDqnXbyVyERSjJ0/EBMs/TInX300rcNUzMZqOaNXA
 ZvdXnBiGhrN9/6xfB5fzpk/i+2CjIxlLsErOQzsjfhC8TrBr9rOeYAfXwyhcQyaN
 pfI6nn/9Zpgexbyp+6RXFMnv3ddi5Jlwiyzgh+hWMuXtLYI0l2FuB5IPJgOG/f35
 cEWxjT5BPlLZgnPeezNS2aFm2t2wZgS8S8Malb/VFDiWELIiEchHxfWnO/diyqY+
 SX5eiw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470bcbp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:30:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-351788121cfso8637897eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792009818; x=1792614618; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cHaSXuBw53oB/JpIaeNjkMnzhzxN11tSl3sVfsC9c7s=;
 b=e+f5JhQqr85P540iMnr6kBAsTWivmAvq0eDVYphXVg/qSKAeYnhjbH1cmYB9QHbItN
 +ziQlP3GwrzdtciEMZtaR6gFqnmcZJPSWQwvlpGAFYxdzKnrM9pwcSKI+opwn3EwFi9i
 U2jMb4gEJL1/ZO6a7BrrWS8yliLplb2QbX6pyWablEKyfYRZkdKddQr4XjE6ys4CjUdM
 /5gAECPeTvnLdq24x6twSTOPkC/wqZyMau7ekRmpC5gAPJHyYTlu24zrPcgfvF8hHSh/
 Hcxck05J0zcioznXl6Rt+mQpn7Gix9jopq5FaaPdDESv8L9qQIqEHj1ocR5AcLHt3tfK
 tCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792009818; x=1792614618;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cHaSXuBw53oB/JpIaeNjkMnzhzxN11tSl3sVfsC9c7s=;
 b=fH8onwT66WBW2yNIHXUTpaPli97HOZ/jWTNG5GOFhg+l4K1/ALAl7fhGlhPcytUXGy
 GeFfgmkEUPdZTBS97wZNXOTsaq25hqV1UM9zM9COWD14xbWJKf/K6C/im5NananJ7dw3
 p3qdoeFURhhO9TJXfbvYiQDiz+3w+D4dyaXjOJ2hXw2MbnkRJVpoybw3Aiwk+n4WmA3f
 O2BapohkiVE4LAkMkxDZwdiaADX35l1bc122WqSdYjrFwll1xoJMs5CCXBAX2l9S/6LP
 nSVu3pHmZpPNO3eAVb42EoKYkDf1XNL+b/+6Ka8YFm+Xb4EyhbWxc992nSGlRnRT27yV
 yYnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9ZIkYBgVRi3I+FIPkdZ2sEjgVn53iS1MqOX0XxlBatFLJO4Sy8pVc7XA4Xw5mrxfcZY2rnzt/E3J9@nongnu.org
X-Gm-Message-State: AFq9FYJw5j6y6bFczgW5OYVSovohlM5R1oFmqjy9YoZVpvjPHR0JUzAF
 wcR55G6buOxsIbvaIJr9ZFYzA0BXAUvwIB1E+YU4FjptY0acQq4/TDzu+emR37vv6bhDVBZ0hAw
 eKWZXz0NBTb4Ux6bTYNmOkLLS40IoLYEx2TGdTPsYkOE5zasJDt+sC00UqA==
X-Gm-Gg: AYBFou3CMOrspFQVCN9kXA/FWbZ5bkzMXKJSSSPo8tfAHUJoOmn7622Z/gfg1oe9CLl
 QwClxv2Nu/DIy1cKYVYdBw7Orns2PxZPRUTIPynwja28wTtIiIXPTMyTciBIedr4hqPI7z58jBg
 k/4QWwjNxy8tDelA0IC4BhXznLh/BZvEHedyQcyZ8Un4eaDC/A8fTOMEjjiJIMkyWs3fUKSAkRS
 UDiw+uP5DJ25bgtQODGlkjUf2TCY7HlfzXXKtQf5pDwXswtuMPW/ylknjL+9AmpKvNQXgrwiwjW
 gm/wQ39ahd+TJ03dDipw9e2Rs2qC/0cNeo8NdQYvHFjJhlPkVMfp6VhjcuUWFpqwnIrnVYY9LGG
 GviDudu8BGFpE2/3S2B9EYrYtXKap71orxYheY5w4bRhyl1z+euztaLz3e5Kbo16QYEqflw==
X-Received: by 2002:a05:7301:db81:b0:35c:73bb:a81 with SMTP id
 5a478bee46e88-35c73bb0d65mr8055602eec.36.1792009818303; 
 Wed, 14 Oct 2026 13:30:18 -0700 (PDT)
X-Received: by 2002:a05:7301:db81:b0:35c:73bb:a81 with SMTP id
 5a478bee46e88-35c73bb0d65mr8055560eec.36.1792009817612; 
 Wed, 14 Oct 2026 13:30:17 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-359789fde97sm40305101eec.20.2026.10.14.13.30.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:30:17 -0700 (PDT)
Message-ID: <bbb6a79a-e952-4724-bb50-414245142960@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:30:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] target/hexagon: preserve callr target when Rs is LR
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-10-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014195223.3233623-10-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX1vU6R6+UTaEX
 Dn5ZgAgINV/KNdrSwqw1LFw6wcSvwwd2i6gu3LLrShxrg/tYBX0ynd7/i2BvRlm6l2PhLlXjQCL
 pdfjRpofk5zGxQEujFtKm7nzbHpJUDm9hDICIU+mNf8F9UuBoUcjR3JHVwpMstqey651hLzR1Bb
 1cWoWuHcAbHdnIluE8VsA61LU3fu+FemQKTuAwvTJf2kbpF/0G3wxLKTo13XWiWz+bfruIyJtz6
 KCHeqnSY9gfZptd/lYRZxIQUBEiaEU1mxqz2n2UTy1nsGEZS8raRCTJ32spOXuazG7H2EbL0cN4
 X7Lmc6GmvsHeOx8FDNApJvPSHtbDTDUCPOwGMu9u/U40C6JLbjTL1N6EpLa/7YLGYsK0EootUOi
 kS3avN23uwq9ezrUeFTCdGfS2nBMMv0FjrUCwiiIdeT5lGb8fX3J2TYONPaQP0gFZ99Lfwv0Xlf
 H3pavTs45uPuCq6sHxA==
X-Proofpoint-GUID: 4nk1ozHe7bVkdHIgDrh8_31sJ3gMZ-IG
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acfe65b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=qGfIP2fYMrPsKiidr-YA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 4nk1ozHe7bVkdHIgDrh8_31sJ3gMZ-IG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX0sjfRmAoVwPR
 koAhv60Rq381C9db8jk6bi/t73IXX+CfbduTkUmMPkg0XDq38vAW/pg8shYfnP/ft/mSP+t+N7y
 tUR6HHm95dcu6kWFHy06pjQq2N+72QA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140081
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

On 10/14/2026 12:52 PM, Brian Cain wrote:
> gen_callr wrote the link register before consuming the target, so
> "callr r31" jumped to the new return address instead of the old LR
> value.  Copy the target to a temporary first.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/genptr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

