Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23B6C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBa2o-0004YD-D5; Tue, 29 Sep 2026 11:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBa2T-0004XZ-C2; Tue, 29 Sep 2026 11:46:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBa2P-0000xU-J2; Tue, 29 Sep 2026 11:46:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5avZ3836672; Tue, 29 Sep 2026 15:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lUw2HU
 o5epfh9F4nrO+cEbr0zv4oiDPHkwj8Op9uvT0=; b=sajit+dCHP4NNMqmOdZA2B
 WsjxSiyhpx2CYLSK3vwcPL76eYzRdlm3gLbph3L/2tFJdws3ZvrvrF09EiW+FBbY
 9FbPg7RQcMZ1ZZWbr4s6r5S+SK9KApaeTjgWnyH4xgue9BbYt/R5W078EUMiVIeE
 67A10ghwNYlAgoFji/poh4QdeY20bKV7EagxXY+E5gFxgZoyVdTCVMbW6JVfbLbs
 Wxt7qeYAUS2zfj+6Mvr5327pPjGmxCukbkeaeWPc+wsbXGnRb0YesxKYaK8rn945
 l3MamIuhlrPLy1vk1leiFJb2HQbZwxJipIk0GZKb5zZNRe+1Zj8+aPj+CTEDeR5w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk7gst-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:46:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TF6HNl1617052; Tue, 29 Sep 2026 15:46:22 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrwafaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:46:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TFkLRY4457090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 15:46:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AF075804E;
 Tue, 29 Sep 2026 15:46:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9CBB5803F;
 Tue, 29 Sep 2026 15:46:18 +0000 (GMT)
Received: from [9.61.92.210] (unknown [9.61.92.210])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 15:46:18 +0000 (GMT)
Message-ID: <47358c8c-1c1d-4175-bad7-4745e406046e@linux.ibm.com>
Date: Tue, 29 Sep 2026 11:46:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] s390x/sclpconsole: fix indentation for
 console_reset
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 filip.hejsek@gmail.com, farman@linux.ibm.com
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@mailo.com, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 qemu-s390x@nongnu.org, brueckner@linux.ibm.com, cohuck@redhat.com,
 maximilian.immanuel.brandtner@protonmail.com
References: <20260921121641.1354712-1-maxbr@linux.ibm.com>
 <20260929152012.2696005-1-maxbr@linux.ibm.com>
 <20260929152012.2696005-2-maxbr@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260929152012.2696005-2-maxbr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: aH8ShY2U1OuLiAUSVUH1StDafXx85i6r
X-Proofpoint-GUID: wVPjOAl134PAOWHhthYXhvUs6bWAHDIU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2MiBTYWx0ZWRfX4XNGeTHqIeFH
 Kh3v+W+dIYNiU3xH8iZjQLt0guZr4v9i7isb4Vn7uzrH73xJ0DosJ3dPHvYZ00C22u9spGRtUCl
 lF804mB3ve01XIGu0iVldryU/PaEnSE=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abbdd4f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=dFsXsk1yfU7eR0EVhoEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2MiBTYWx0ZWRfX6W+rzf7l8f/q
 KjHiZq9ft6sqm0nNjX0Ky0VGaJP3EDoN6pLosnKAbPYNI/uiuAObxeSXbrm8XE+1DdFLm2obSUm
 eobrDCdhy/n6sJHFjSwA3qsqeHJccNhWY6XIO6IOtEeEtblh+sh8EOlCoBzsV77RgZxXP5elUVf
 dNtmtD8hSYai0VoTs1el2SlnfOgYBCZ3wRm8B3KVa9zPxGQ1nLh+b76ib84JwfXN+tW5GVegoPJ
 rCqRirLhepPxqreUxBqKEdRXEdWEmlLbo1jrqH9X3eZlL07Nz3oirH7SjW8yYBb8BK22r8imSa/
 ty8E5JPhgqd6AN+Xcp9cCGpYcSd73zCIh3/MERGxjPR6bLyG8l8wYPSBNEGVHkXEdUlfy0dQp1a
 Xe5/LWXnuhebfIlC8O/QWC/GGXOC6R5KjlcOY9AMR5vJE70bZ4Cnd1XwNEz3CNnaGc5WKlqudIy
 dZn4sQ5a+lBI7CiS19w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290062
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/29/26 11:20 AM, Maximilian Immanuel Brandtner wrote:
> Adjust indentation to match the rest of the file. No functional change
> intended.
> 
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>

Thanks.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

@Eric this whitespace fixup applies cleanly to master and could get
applied separately if you care to -- or it can remain bundled with the
resize patch (patch 2 of this series) until we sort out the fate of the
pre-req virtio-console series.

Thanks,
Matt




