Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D3606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LqYY7DGB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=glEaw5nc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMBRz-0008JX-9K; Wed, 28 Oct 2026 17:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMBRx-0008JA-6k
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 17:44:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMBRv-0001iK-K7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 17:44:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIcLb11918635
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 21:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zg0hmOj9aMW9T1A6MPbF+6VFWcnu0Fwji/PPaUeTYAo=; b=LqYY7DGBouhvvblO
 +4ELGWkxXIkGez4fKF0Rh5TJj4QcxsSGc/6ZmVJWOG4kWsap9dB8U3jsqpo4qrSm
 KCDsWw2wHP1BtdjKdCrUi24KfEFWTn9i2wAK/WjQdSIV7Qpq9hfOu9gBXGGMT6lb
 wS01vkl6qGRY4pWEplZ3fyyLAjLC5mJsfftI/re6DIPb2L1A/aEM7z3pCv1H7L96
 BdI8Oa7jDHzp7u3Z/joP5/bNa4PMysqTPqsdyfEYAfn1bNtHJBdE9N7AzcGSNinU
 wpNjFvPSY7kSpK9VoSPGUS+fxX4vVKWK4w/2jRERhl/lDLKb8KFH0oF4h3SjueAI
 Y78B9A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpgprkd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 21:44:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3425098ae4bso201286eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793223885; x=1793828685; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zg0hmOj9aMW9T1A6MPbF+6VFWcnu0Fwji/PPaUeTYAo=;
 b=glEaw5ncXNoGhfuFv1lYuVNbHFhWyytL+0SZEobdsm9WeYT1vBG6O+Ye1jj6+EG9ob
 FMFNEloSsIao9iMXMDrRIqRdHiCl9KNbY7Dts62Ikvb1Qn+nxwK6TrTB9tY0Wrii8SM/
 KA7yLtNAqT6/Z4ezOT9JTifHqs79HOnw7QEbpAYy9lR8tVdkaU0VNbwmZd/gSQVL9JFe
 HKS/GJkBpC6fOlko/ZPymAxyS0xh8FKTS2UjqemA8zyXdw1geAswaTD9EzAdB0zF1WA9
 UWtNRf3kP1xpG9dsj3RU6v1tsk33m7nB3yU+omU4Q/MkIj+raP5LL1scasqvMwcJiHkj
 F9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793223885; x=1793828685;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zg0hmOj9aMW9T1A6MPbF+6VFWcnu0Fwji/PPaUeTYAo=;
 b=OCXi9CslPHkMoKqLhKMfT/YbUG71hG/A/lA2kCO8vdaGzH/BRVBrH1nZ3zuLFa+bul
 ZopX5tKH9NBp/PtzYM6u+akgo3096serYYTKd/eZKhgZqozwf9FEPmxFklcnt1Ivj/Xa
 GIQbeLwKNoLhsoTZn9CKZItV650ZDmMEbunLvkhqfgpdNWR877pBYR6NFHnpJu1mH1Le
 xVoyTlp4n9KFzKb+lfQX9BMgednZYV4k6FhwWTzTKUekxpfT61/aikx7uAJDGpMlCCGT
 dvLoV8GpTthN/0lEAMbKO1vaG7ZeSq0+hpYRvgAviKZ4xAy7rG6hFexU+tkNHkHjBS2G
 F8Yg==
X-Gm-Message-State: AFq9FYKrphmY86oaW3NskY74dM421l+w5q9Zu1ZKnMVgw/SHTCDyOlsQ
 m3iDFcB5+QIiHf5/VUDUC5j/w+Pei2Re/SaBhFwttsAeCooUuzLxXiszvyO2fATYovzb+bevWv3
 xSUftEO44zECINqUR4EFhXOFexCkj7i+Ezd2erMff+YC8bik94u6rS3+0Kw==
X-Gm-Gg: AYBFou1pSQv2EHuO2dy79FD2p6k3HP0WmvdMnW5sdPSox4T95zaXJyKiof8IqwbXp9u
 7uYyVzyiMydwBdVl73iSR07yYyxhmyIW8ijdSjyEVO+an5WloALknylwp5soj+64kGwYSodXGFD
 vO5ZCsvsiFlOfxN2CMrpLmiWgucHMTMHfOpnI4pK7dfQevPNSNzS2TB+J4H8zfLaRrgXMCZ24wg
 BHAKW72NHq/pmn0K++96HkT4Ie3i+Xb6HWPNe9kzcb6A4IvqOFuetIrrlxhdaSl6a0Vr6uu4a2U
 qJTWSOOx7SXhYw4143s9G5gWToHCbHfTYADZKbj4YGT3aGhHOz/ahpE0+zER1eUJDd8Puw+bv4B
 VolxFF0Rqbta6t5kYg1mvPt+RP6UgfZh6efU3pdv/6/GKqJIQGKYqRTAQF3G9gmCSlkIsD9DPFr
 h+J7oGxXfymg11FJNtunoGernSbd7KKYkQovEjRk0PDCo=
X-Received: by 2002:a05:701b:2508:b0:199:4d4d:d3c9 with SMTP id
 a92af1059eb24-1a94b0a7b59mr793629c88.25.1793223884725; 
 Wed, 28 Oct 2026 14:44:44 -0700 (PDT)
X-Received: by 2002:a05:701b:2508:b0:199:4d4d:d3c9 with SMTP id
 a92af1059eb24-1a94b0a7b59mr793592c88.25.1793223883976; 
 Wed, 28 Oct 2026 14:44:43 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75c814aa1sm15601173c88.7.2026.10.28.14.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 14:44:43 -0700 (PDT)
Message-ID: <88bbbcd6-1826-4dd1-9bda-4d193966b67c@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 13:44:42 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] hw/virtio: register s390x virtio-blk-pci and
 virtio-net-pci variants
To: luoyonggang@gmail.com
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Farman
 <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
 <20261028201557.2688-10-luoyonggang@gmail.com>
 <b59162fe-5f8d-4923-b6ff-133b8fbf1a41@oss.qualcomm.com>
 <CAE2XoE8vapLZzawuDMQEnOGZsymec+EVUkoWhxUKxbrqmAHoOg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE8vapLZzawuDMQEnOGZsymec+EVUkoWhxUKxbrqmAHoOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4NiBTYWx0ZWRfX4m0+6fubkD5h
 fenANXyvOhHuDV56Ju3PhIz0CUh/mpOEf3ydFAc96zkBBNzL1KJO20tLFNIuDPUqxiSWbees2kK
 aihcHmVg7b/Z7K637g85M4Deqi6NpsQK5RDyei/PALNBjc9XlTDI/ubgYRWQQ4rFVEQSZ1CYV+M
 YIR4jx2JSWrdcKbsLY5m5xRLqdHhIFdB6UV8G/IxnTyBr6BhRCT3DtueDge67HOzdX+Q+LOpxB3
 hC40SNxINlr4t/RP7tCK8KgKrC0aA72hOMYkHsJFVAiHg2jDohQf5GMjaBF9iJM2c5JBxI7Q0Lo
 nZqhk9l0cJ+LswF91QbVHat4Ye06QkX5ccMEiaFZ4QlqfLNyJMAmExZ7syZTj65YntMJgJfBgck
 vkQAg7yycvIZkYrV61pUdhcWGC2/guGTRUPOLqaMqgOfiVMRZvp73i9099E1lC2BI5U/bUTXGic
 Ub7A1kz0I+oDndoN7mw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4NiBTYWx0ZWRfX19fWKtDSNBJ9
 sxfXCTyvaiJUrDps7l+EhAgIEIThPiMfluR30hEW3/HwqMq4cw96m/5l64qEH+zNVERr3cdy52T
 ayBuvRpxvLtDHBgRgWYq+XXmjtoXRps=
X-Proofpoint-ORIG-GUID: lhyA76-tEUTmVxf6q_b_pKNIuDEj9DHS
X-Proofpoint-GUID: lhyA76-tEUTmVxf6q_b_pKNIuDEj9DHS
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6ae26ccd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=7iWLHl1a1dHi_J-wnTwA:9 a=lqcHg5cX4UMA:10
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280086
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 1:43 PM, Yonggang Luo wrote:
> 
> 
> On Thursday, October 29, 2026, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
> 
>     On 10/28/2026 12:15 PM, Yonggang Luo wrote:
>     > virtio-blk-pci and virtio-net-pci added the s390x loadparm property
>     > from class_init when target_s390x() was true. Register each
>     > VirtioPCIDeviceTypeInfo twice. The s390x variant calls
>     > pci_qdev_property_add_specifics(), which now always adds loadparm,
>     > and the other variant does not. target_s390x() and
>     target_not_s390x() select
>     > the two.
>     >
>     > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com
>     <mailto:luoyonggang@gmail.com>>
>     > ---
>     >  hw/pci/pci.c               | 13 +++++--------
>     >  hw/virtio/virtio-blk-pci.c | 22 +++++++++++++++++++++-
>     >  hw/virtio/virtio-net-pci.c | 22 +++++++++++++++++++++-
>     >  3 files changed, 47 insertions(+), 10 deletions(-)
>     >
> 
> target_not_s390x will be duplicated at many place, is that fine?
>

Good for me.
  
> 
>     Fine for me, let's see what virtio maintainers think about it.
> 
>     Regards,
>     Pierrick
> 
> 
> 
> -- 
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo
> 


