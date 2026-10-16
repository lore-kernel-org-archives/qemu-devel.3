Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7656FCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 11:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHff8-00038s-UE; Fri, 16 Oct 2026 06:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHff7-00038R-A7
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 06:59:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHff5-0007Cl-5W
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 06:59:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GAA6E71983107
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 10:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RRFToM0ma4CDmnuwQUVbq2Jg4BaRCdz7dffemXt+eYE=; b=iVqTiCaRDHXAnQTl
 3aSix0qIUP02/T0U38oileFkR4KG+0u9ockf35NBZjRBsumaRxgM6E2zkObTYfQh
 zA1t5WEdJUKRUq/LEDgmWbhe/4T8qoeB7DcLmh9ruNz913OnkMqJS4o5HJpICPKZ
 q/RMGFtpApwk8ATYwVbzyrJyDGleFpyiIScwUYSUL1NoD/rZnboH+YEzCWxBYCQn
 GZRP/OmPj+uMBddPQdZYjM7b1vUQWZixwr+wYV9S1lTtdq1LpHZlsVds5p7uzqj8
 VuMolTOGoAoCGCLlTzWH3xgi26YFTSdC9jXn3P0nwfqwtda2t7y5HuwLNQyGTwhF
 PM4BSg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8a8aa2k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 10:59:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2005ce21so55996985a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 03:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792148379; x=1792753179; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RRFToM0ma4CDmnuwQUVbq2Jg4BaRCdz7dffemXt+eYE=;
 b=XlqRtMsVElHkkMNg6FtbEUNs42+VVhFDcwDQlurpFICA1vxGH9hpH1u8E5WOO3tiYx
 gDBr0M0s3mXkpC/AlDK+Bx+xK4VsTdcdwzqDWMWWucKYR3LaaORw884nOHhxCw2OB+1S
 1KAVLG2mx3SZoHXTt3ROpGemFDhQjI2I1RzM+dq2aHfdtI5HEzfUlNb3PXXF8UB8ncDN
 YIWBQv01md7WzI4x/MMWLyo/LdnFwdacmgJIoeTEvW3xfoskcaJlVp6po7M84EfJtRQk
 pPXxklT7yqVuCtaIS60QVAzPCuRPTS2WporldvDtuAtewfSIol76ILBZHTJk4vjb6Sro
 MXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792148379; x=1792753179;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RRFToM0ma4CDmnuwQUVbq2Jg4BaRCdz7dffemXt+eYE=;
 b=x46plRrnysUv2HgMDOK1S7Snw3iYT2Z7huLybDauJIvHrmU/HTWPYmVXnwgcNR6dJo
 e8NmTmmnFZZPEDHl5x0oBmOthQ7OChbr+wANhoql8k3sQX1kOwuBJ6kObQs9eplx367F
 hqi4SSLYlmLDWsCNRZYGjWc2hRBtvxlQTF5QaMkUKqkJ+PKqivk5P5eOxK2wOLC1Hrnw
 zi27id3pRcaTruBdKXEByopBpJBdifmlzqOyVyyWdiwscR4b8cz1IGXqB1mTRB/YL1WL
 qFWDy/O5rV5bPv1XQvgK9qc9tSovlOu4O5vdLST8xiD9pOde0GJFqtT5ei3xL83wfTB0
 2GvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfXafMZNQEFFnP1DilTIPspUdQ0gt9fb4Pd8hFrYObEG+0cG014VuCSoaswyy4Xl8klIy7MH9daN7v@nongnu.org
X-Gm-Message-State: AFq9FYI2kZ0QlzWNuBrM61rNT3AIJ0nYWhq7VMV1SQLlfwRtmvoFcPzK
 OmVKdFNnL/Hyp9KfGOQHvXJNuwqxux+b1lf9cGa9+Ydg04mehJgTIG14TgdktsobPzGlfXN8wYb
 ni3AATrpOZBZj1N0SrPeuKsuu0RXisfl0DH0z06t07O6yzAqca83UUjfRRQ==
X-Gm-Gg: AYBFou2hDFfgrt3Qosaz8okVfL5z9mv4Jqqp2jUMfHcu8shp5FoIGXzffXHKFXfUAje
 PBANM6EjhI6+mVG1Pt/lLlM8KBxXx+XETBbDUvQpKRQOPp7K/AvaCrhw8cRDwS38Q+SbcrZUjzs
 h4E2jyJkpKo3ZxhzSYOhF8uvcrFK23JlLaQAchGtvd3pUZQIKjUSdTPNdQIudvNPpV9MxiHKsjp
 QoP4KbKxROESTxhiaP+5zh4xvNTm5kqE/sXYjUUILTVVokl6wenOjP69Kq5/AY2H/h7esLoz+1G
 9nAMAMXocGsvQMKGNbwnZFkQZs+j7lzXFqFCOreJIM6OLZo8EJZ0jjOfeftIgka7Ukb9XCHDBOk
 nN1FmcA0PBF44XgY66v6fDFS71TB+rCYWDg==
X-Received: by 2002:a05:620a:1a0b:b0:93f:216f:f404 with SMTP id
 af79cd13be357-93f216ff565mr97181685a.40.1792148379264; 
 Fri, 16 Oct 2026 03:59:39 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0b:b0:93f:216f:f404 with SMTP id
 af79cd13be357-93f216ff565mr97180085a.40.1792148378821; 
 Fri, 16 Oct 2026 03:59:38 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8af2fcesm53644595e9.8.2026.10.16.03.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 03:59:38 -0700 (PDT)
Message-ID: <d3d9ba30-e28e-44a4-8531-52b88a8b5943@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 12:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] multi-target: remove dump functions duplication
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <5aa90efa-5bbd-47b2-86d8-8e1552161668@oss.qualcomm.com>
 <faa22811-7a04-4077-8e26-b89be0a0c972@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <faa22811-7a04-4077-8e26-b89be0a0c972@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MyBTYWx0ZWRfX1H7NxcUEoSNw
 ltjtUc96pboaCO4lLkIzUCZpWbrGde4olCjCF60HA5MxD3lnSIxppQweAdbbdxOeuEyYDrG+adY
 JnReb2nvrO3dMITARhLx1/CG/On+yxk=
X-Proofpoint-ORIG-GUID: aZjuNaWp8-4cSOt1hmH_YLEC20x-MVIa
X-Authority-Analysis: v=2.4 cv=GJadgeNK c=1 sm=1 tr=0 ts=6ad2039c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=vAcAjI9A3QUpiSO3UmcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MyBTYWx0ZWRfXzdRKnIbuO2nK
 AG/a2L6YXgbKUSiv/o1h2BWrrZMYAJgS3U3JxxwjqZN+XSAL8xUrRYZ7+SQvbV5TOC4VHCPiLz4
 3f9Zpb9C0CB+/vRcak4nGWI6dTh1shTj3X4PnQk0PXO4HuhxcgS401O6gSIxwdGwnLb34CtwYhv
 JAMTFa/JZD7C7lERWRo4lFiOJ+JwTXqotNTRYL4YCv0zCkeOGBuoCfVeDXqi9SfaMks48jxKyJy
 Pxya23DlNSaLrhzyIrwFyjEXClnkhnxfb06H/XoN9Yz/y2Xx13ePeGPyMsTjHUZryASCp/lAyyn
 gOetSmh3JYMZDPWv29dmIGL57jRcV6Vr3viVuxPhQKvZjKyLuBeJOsSPhDobC7P/m3uOSs/wvhh
 b4z68JTGf5tzKbfUnyGxGlpwVv7alHyG8LM7OFCz1mxlp5KdQK8t1KMbKp+zZM74ljLy/g1dnxs
 CsYnPfhtPeJJJGoFlHg==
X-Proofpoint-GUID: aZjuNaWp8-4cSOt1hmH_YLEC20x-MVIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160043
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 16/10/26 08:42, Pierrick Bouvier wrote:
> On 10/15/26 10:59 PM, Philippe Mathieu-Daudé wrote:
>> On 15/10/26 23:32, Pierrick Bouvier wrote:
>>> This series removes duplication of cpu_get_note_size and 
>>> cpu_get_dump_info per
>>> target. For this, we define a new set of Dump operations for a given 
>>> cpu, and
>>> implement it per target.
>>>
>>> Existing implementations were using first_cpu, which is what we 
>>> continue to do.
>>> When we'll work on heterogeneous later, we can revisit this to either 
>>> forbid a
>>> dump, or perform a dump for each target active.
>>
>> Make sense but this must be documented, in the code, and commits
>> description.
>>
>> Maybe we can self-document adding '#define qemu_heterogeneous() false'
>> in a core header and asserting !qemu_heterogeneous() in the dump API?
> 
> I can add a new function target_heterogenenous in target_info, which 
> returns false for now. And add this check in the if for those dump 
> operations, saying it's not supported in this case.
> 
> What do you think?

Yes please it is cheap and that'd make us safer IMHO.

