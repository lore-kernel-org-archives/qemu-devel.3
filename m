Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FA2CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGd6w-0002BO-SO; Tue, 13 Oct 2026 10:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGd6v-0002BA-7J
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 10:04:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGd6s-0000zH-Hp
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 10:04:08 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE3TLM442761
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 14:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QVeB7GW19pUYTyp1T2SeG2XimB65n4wwpwjVHdPJyVc=; b=DIRjweQjTU3FNTRx
 OL5ECR4sOSb7FPf4sc4EB+ikE/udLDvwUMUUAPR/JYiLvccAjiIZReP8KExnyMfR
 8hNTm56qcOB1ITQVErb80lGXj84Li/AJbm+0HS39PffdfZ+RqLLsh2JJN9FXBtlK
 2ArEsLiKlWvFpEmW6ga1Lg76r2roc4oBtlHUnxin68kbdrSNTKkOczSHzOR4OxQd
 8e7V4MukCr3H2B7j0imxrAnU1j+h2vqjOVw5ZjGKBQPNjYUGX93LanYWJ+/bfM6B
 FOd2iyJxtCKl2ReNln3TTaZSBrGp1/l5EEMvi/lUT1s9PmWX3VXRHsOWNjHPCCbe
 +HzfJQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9n71g90d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 14:04:03 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5df1badcee9so2447797e0c.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791900243; x=1792505043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QVeB7GW19pUYTyp1T2SeG2XimB65n4wwpwjVHdPJyVc=;
 b=AFnOG8ZsIEyjPM6qNfbF2ubrjL2NyBS64sAxZD0lxji4kdrbrsCbUjQnJJaQKyf+OZ
 jSGPe2FjKBsmtFRVJO2bHJef7G37hT6H3Do37qj88sZ3+FN5ao028aWW4ghEKJnMRxOn
 DnwhFgkBnDAsVE3RRYqgVcI42iPxYMPnqhzad9XhuErQx+Sxhcb1TxwbedxMnbwjBV4O
 JiaK05pl50MzI4B1dMIYeOGQpbMK/44Of0ixqpCvOSndY5Hg0SKdHC5TZ3RF26oUptY3
 NqzqXyHYIlGffs04swQiaJQ3G4slrRXb6L9GK3F9moTsZStZtnYFJZ1venKygq862cOr
 qGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791900243; x=1792505043;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QVeB7GW19pUYTyp1T2SeG2XimB65n4wwpwjVHdPJyVc=;
 b=Rl4MADAhTZPBLqpx3BiP6IYVh7bb7NiKCgp9SOO38uLvxkU5qHzU65EFYIGmtHkNoW
 nEiCObgDeh2SdECqnDSEaSa4nNDlrF1bpqkZNeI0kbV7efS27vo1nl21R6CHHeW6uktG
 oz0tfDPBCKShSfDD60fW9eSmNGgFAz56d5etzO75YgrK19o+JP1TqTZAK0fY9iOi5q3i
 59ZZ/t20kLgQ60+ZJOsvhcGFagZYAhsMUwHaghTwFE35rgbEcTZaFmefG8X01deGfHOB
 PbJIYHt6cFurZV8bgehju4i9vCYGUTKbPH+/Ey/a4mNzU3cdQmGaZEs6AKisg5xtwNGE
 U0og==
X-Forwarded-Encrypted: i=1;
 AKwUvBxy5+XPlxx2FeI06RHP/qu4z5gnjtUn14NRqPAFHC65ST7BLMeGbhFq4HFNdlsbmwnvasQaFNEvR1uU@nongnu.org
X-Gm-Message-State: AFq9FYKyJhtM7uPXrQrPGwmnY6ZXzw1boMvBbXrqTTEjlgl1mdquUDFQ
 kh6q18t6zYYIwlpX0Z8FxWdhKDkrLYeW3J7FhUi/nvwBRa7kG2fgd3pEuHwFn0AM1tcqVURMhPW
 OwzAEeFO7SpM2VB8r14W9l8NQd2k7YQhNqO7hk4ZvyNlQDFheubf38aEZXQ==
X-Gm-Gg: AYBFou1nOI8KLg9TGj55suZDJBPxNwo4Txi3LxaQNKl6YWh/0Iuf7tEq01vewPlnkMI
 G7T/LMB8yYk8AYLBp8dvRKaM3Plj7RjSQRu1guj/TxGTsJd7II1uut3mNdGpXRGve+G2KY6O3mZ
 qOcl/rE5Jw3SZxQqkeKB+CLBA4d2TRISJMY0fyu/CsS6VNr0cvZnziGcTZFjteoddc7jFLLnYwa
 mH8Kb6Yg8MR3GI75CvMrJu+76xuVXKKXiUfRbu+08d4RPBxbdaJTwP5C/t/7XjN8uLE6Ul8R7PC
 VqtURB30UJ0NTg3d86MGfgCN8JIkGcAr0h8vVlFWc02I48iinrkq44MEuYRSZHSm4YF/Ua/eheq
 vxkj+LnDJ8NTxw44zG3NtP1i6DV+6KOMP+w==
X-Received: by 2002:a05:6122:9006:b0:5cf:5118:6a9a with SMTP id
 71dfb90a1353d-5e91efb35f5mr4083091e0c.0.1791900242594; 
 Tue, 13 Oct 2026 07:04:02 -0700 (PDT)
X-Received: by 2002:a05:6122:9006:b0:5cf:5118:6a9a with SMTP id
 71dfb90a1353d-5e91efb35f5mr4083040e0c.0.1791900242022; 
 Tue, 13 Oct 2026 07:04:02 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm400979855e9.10.2026.10.13.07.03.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 07:04:01 -0700 (PDT)
Message-ID: <f684fc05-04fb-45a6-b552-a49d91de5106@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 16:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU Community Call 13/10 agenda items?
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Chris Wedgwood <cw@f00f.org>, dbarboza@qti.qualcomm.com,
 Demi Marie Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 helge.deller@googlemail.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>,
 jacob.oursland@gmail.com, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 utsingh@redhat.com, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>,
 Ruslan Ruslichenko <ruslichenko.r@gmail.com>, Frederic.Konrad@amd.com,
 Luc.Michel@amd.com, edgar.iglesias@amd.com, francisco.iglesias@amd.com,
 Julianus Larson <julianus.larson@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Lukas_J=C3=BCnger?= <lukas@jngr.org>
References: <87fqyh79ty.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <87fqyh79ty.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FuqQbGrq c=1 sm=1 tr=0 ts=6ace3a53 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=nXA5WNwiAAAA:8 a=zouqjsRWwLoWaRda-OoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=fGr-7aqQv4RST94IA8XU:22
X-Proofpoint-GUID: WG7IQ1u2vP3eb61XR-WHS-d6sOMyTCEs
X-Proofpoint-ORIG-GUID: WG7IQ1u2vP3eb61XR-WHS-d6sOMyTCEs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NSBTYWx0ZWRfX0IzwZqvpuImh
 B1fX6xkIqsl7TrnZx/Z+pHZWvTcEDiMvGAVYCCXcVCsjiO3Yy/6RbST4Y4GPgfL54XsGNvHCnmI
 EuDk617iOhpMeYAE/T8FXD7Wo7IERbLkeWEIBFO72wNlAKKOxKA2He5nOyPh8fKSlXoqzg/wiHd
 XOMAGha69yahp+8Nhb2TRoIzY90qrEB/r5cHZPU+QPSr4ybIibiTB3iEmwic2lsGU9IulVNBXSV
 pO5yBmj+0yFXRFd3gPZ7q9JqIbP/Iv/TtJfdfMtFCbadnw9CBDmlmwT4LU8EFuRdItkxGiINCC5
 se1h9owxhSGjdkGVTAm0poQQiZL7aI9P25DvgSQdpt/8r9RX8H7zxOmnynl1W+NqqtCmcxabGY+
 B3+6R+dR4lUXWdX1MSIwUmqeniLhT6mvmE5b3dSZ2s6kvxZZJGWy2AnGmTMTQrD+b08JfmXJ5s5
 QZsYYYSkqWsx9AKM5fw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NSBTYWx0ZWRfX4IoPkzCSyafn
 OTsPa6Ajxd89ySraLy0xyDDCpcDH1cUlNmZXh5i2kLr+cnZsG545441usfM2rXcNxWin2H1lb1C
 nOWNaqFUtkEYkdDUxEXGvRF5kGm/pFE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130055
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

On 7/10/26 18:29, Alex BennÃ©e wrote:
> 
> Hi,
> 
> The KVM/QEMU community call is at:
> 
> https://meet.jit.si/kvmcallmeeting
> @
> 13/10/2026 14:00 UTC

"Waiting for the moderator to start the meeting"

